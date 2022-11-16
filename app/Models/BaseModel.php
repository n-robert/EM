<?php

namespace App\Models;

use App\Contracts\ModelInterface;
use App\Services\XmlFormHandlingService;
use Illuminate\Contracts\Container\BindingResolutionException;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Query\Builder as QueryBuilder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Str;
use App\Scopes\AuthUserScope;
use LogicException;

class BaseModel extends Model implements ModelInterface
{
    use HasFactory;

    /**
     * @var string
     */
    static $defaultName = 'name_ru';

    /**
     * @var array
     */
    static $ownSelectOptionsCondtitions = [];

    /**
     * The base accessors to append to the model's array form.
     *
     * @var array
     */
    static $baseAppends = ['default_name'];

    /**
     * @var bool
     */
    static $skipAuthUserScope = false;

    /**
     * @var array
     */
    public $listable = ['*'];

    /**
     * @var string
     */
    public $name;

    /**
     * @var string
     */
    public $names;

    /**
     * Repeatable fields.
     *
     * @var array
     */
    public $repeatable = [];

    /**
     * The attributes that aren't mass assignable.
     *
     * @var array|bool
     */
    protected $guarded = [
        'user_ids',
        'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'user_ids',
        'password',
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = [];

    /**
     * @var array
     */
    protected $defaultOrderBy = ['name_ru'];

    /**
     * @var array
     */
    protected $filterFields = [];

    /**
     * BaseModel constructor.
     *
     * @param array $attributes
     * @return void
     */
    public function __construct(array $attributes = [])
    {
        parent::__construct($attributes);
        $this->name = strtolower(
            str_replace('Model', '', class_basename(static::class))
        );
        $this->names = Str::plural($this->name);

        if (
            in_array($this->name, session('views')) &&
            url()->current() == route('gets.' . $this->names)
        ) {
            $this->appends = [];
        }

        $this->appends = array_merge($this->appends, static::$baseAppends);
    }

    /**
     * Get options for a single select.
     *
     * @param string|array $model
     * @param boolean $distinct
     * @return Collection
     */
    public static function getSingleSelectOptions($model, bool $distinct = true): Collection
    {
        if (!is_array($model)) {
            $model = explode(':', $model);
        }

        $class = __NAMESPACE__ . '\\' . array_shift($model);
        $args = $model;
        $method = array_shift($model);

        if ($method && str_starts_with($method, '__')) {
            $method = str_replace('__', '', $method);
            $column = array_shift($model);

            if ($column) {
                $class = call_user_func_array([$class, 'whereNotEmpty'], [$column, $distinct]);
            }

            $options = call_user_func_array([$class, $method], [$column]);
        } else {
            $options = call_user_func_array([$class, 'getOwnSelectOptions'], $args);
        }

        return XmlFormHandlingService::buildSelectOptions($options);
    }

    /**
     * Get an item property value
     *
     * @param string|array $model
     * @param int $id
     * @return string
     */
    public static function getSingleValue($model, int $id): string
    {
        if (!is_array($model)) {
            $model = explode(':', $model, 2);
        }

        list($class, $properties) = $model;
        $item = call_user_func([__NAMESPACE__ . '\\' . $class, 'find'], $id);

        return array_reduce(
            explode(':', $properties),
            function ($result, $property) use ($item) {
                $result .= ' ' . $item->{$property};
                return $result;
            }
        );
    }

    /**
     * Get options for form select.
     * @return Collection
     * @throws BindingResolutionException
     */
    protected static function getOwnSelectOptions(): Collection
    {
        $model = app()->make(static::class);

        return
            $model
                ->applyDefaultOrder()
                ->whereNotEmpty(static::$defaultName)
                ->get([$model->getKeyName() . ' AS value', static::$defaultName . ' AS text']);
    }

    /**
     * The "booted" method of the model.
     *
     * @return void
     */
    protected static function booted()
    {
        if (!Gate::allows('is-admin') && !static::$skipAuthUserScope) {
            static::addGlobalScope(new AuthUserScope());
        }
    }

    /**
     * Scope a query to applied filters.
     *
     * @param Builder $builder
     * @return Builder
     * @throws BindingResolutionException
     */
    public function scopeApplyFilters(Builder $builder): Builder
    {
//        Session::remove($this->names . '.filters');
        $filters = session($this->names . '.filters');
//        dd(array_filter($filters));

        if ($filters && $filters = array_filter($filters)) {
            $this->applyFiltersRecursive($filters, $builder);
        }

        return $builder;
    }

    /**
     * Traverse filters array recursively to apply them
     *
     * @param $filters
     * @param $builder
     * @param null $defaultKey
     * @throws BindingResolutionException
     */
    protected function applyFiltersRecursive($filters, $builder, $defaultKey = null)
    {
        array_walk($filters, function ($value, $key) use ($builder, $defaultKey) {
            if (count($value) != count($value, COUNT_RECURSIVE)) {
                $this->applyFiltersRecursive($value, $builder, $key);
            }
            // If there is a simplified filter, then we just apply its original options to query
            // Otherwise we will apply the "where... IN" clause to query
            if ($options = session($this->names . '.queries.' . $key)) {
                static::applyQueryOptions($options, $builder);
            } else {
                $key = $defaultKey ?: $key;
                $builder->whereIn($this->names . '.' . $key, $value);
            }
        });
    }

    /**
     * Apply additional options to query
     *
     * @param array $options
     * @param mixed $query
     * @param string $field
     * @throws BindingResolutionException
     */
    public static function applyQueryOptions(array $options, &$query)
    {
        if (!empty($options)) {
            array_walk_recursive($options, function ($args, $method) use (&$query) {
                $args =
                    $query->getConnection()->getName() == 'mysql' ?
                        str_replace(['INTEGER', 'INT'], 'UNSIGNED', $args) : $args;
                $args = preg_split('~\s*\|\s*~', $args);
                $query = $query->$method(...$args);
            });
        }
    }

    /**
     * Scope a query to default order by.
     *
     * @param Builder $builder
     * @return Builder
     */
    public function scopeApplyDefaultOrder(Builder $builder): Builder
    {
        if ($this->defaultOrderBy) {
            array_walk(
                $this->defaultOrderBy,
                function ($value, $direction) use ($builder) {
                    $direction =
                        (is_string($direction) && in_array($direction, ['asc', 'desc'])) ?
                            $direction : 'asc';
                    $builder->orderBy($value, $direction);
                }
            );
        }

        return $builder;
    }

    /**
     * Scope a query to model's custom clauses.
     *
     * @param Builder $builder
     * @return Builder
     */
    public function scopeApplyCustomClauses(Builder $builder): Builder
    {
        return $builder;
    }

    /**
     * Get the model's default name.
     *
     * @return string
     */
    public function getDefaultNameAttribute(): string
    {
        return
            array_key_exists(static::$defaultName, $this->getAttributes()) ?
                $this->getAttribute(static::$defaultName) :
                call_user_func([$this, 'get' . to_pascal_case(static::$defaultName) . 'Attribute']);
    }

    /**
     * Get pagination data for items
     *
     * @param LengthAwarePaginator $items
     * @return array
     */
    public function getPagination(LengthAwarePaginator $items): array
    {
        $pagination = [];
        $pagination['links'] = $items->toArray()['links'];

        # Generate absolute link URLs according to scheme
        array_walk($pagination['links'], function (&$link, $key) {
            $link['url'] = app('url')->to(
                ($link['url'])
            );
        });

        $pagination['previous'] = array_shift($pagination['links']);
        $pagination['next'] = array_pop($pagination['links']);
        $pagination['onFirstPage'] = $items->onFirstPage();
        $pagination['hasPages'] = $items->hasPages();
        $pagination['total'] = $items->total();
        $pagination['firstItem'] = $items->firstItem();
        $pagination['lastItem'] = $items->lastItem();

        return $pagination;
    }

    /**
     * Get the filters for showAll()
     *
     * @param bool $skip
     * @param string $fieldName
     * @return array
     * @throws BindingResolutionException
     */
    public function getFilters(bool $skip = true, string $fieldName = ''): array
    {
        $filters = [];

        if (!$this->filterFields || !array_filter($this->filterFields)) {
            return $filters;
        }

        foreach ($this->filterFields as $field => $options) {
            $tmpKey = $this->names . '.filters.' . $field;
            // If field has no model, then we will assume that filter is simplified
            // and just store query clause in session
            if (!isset($options['model'])) {
                session([$this->names . '.queries.' . $field => $options]);

                $key = $tmpKey;
                $filters[$field][$field]['name'] = $field;
                $filters[$field][$field]['value'] = $field;
                $filters[$field][$field]['field'] = $field;
                $filters[$field][$field]['checked'] = session($key) ? 'checked' : '';
                $filters[$field][$field]['action'] = session($key) ? 'remove' : 'put';

                continue;
            }

            if (!$items = $this->getFilterFieldItems($field, $options, $skip, $fieldName)) {
                continue;
            }

            foreach ($items as $item) {
                $item = $item instanceof Model ? $item->getAttributes() : (array)$item;
                $value = $item['value'];
                $key = $tmpKey . '.' . $value;

                $filters[$field][$value] = $item;
                $filters[$field][$value]['field'] = $field;
                $filters[$field][$value]['checked'] = session($key) ? 'checked' : '';
                $filters[$field][$value]['action'] = session($key) ? 'remove' : 'put';
            }
        }

        return $filters;
    }

    /**
     * Get items for each filter field
     *
     * @param string $field
     * @param array $options
     * @param bool $skip
     * @param string $fieldName
     * @return Collection
     * @throws BindingResolutionException
     */
    public function getFilterFieldItems(string $field,
                                        array  $options,
                                        bool   $skip = true,
                                        string $fieldName = ''): Collection
    {
        $valueField = $nameField = $this->names . '.' . $field;

        if (isset($options['model'])) {
            $model = app()->make(__NAMESPACE__ . '\\' . $options['model']);
            $table = $model->getTable();
            // This variable is used in getFilterFieldItems()
            $nameField = $table . '.' . $model::$defaultName;
            unset($options['model']);
        }

        // Determine whether to skip dynamic applying other fields filters when getting this field items
        $query = ($skip || $field == $fieldName) ? new static() : static::applyFilters();
        $query =
            str_ends_with($field, '_date') ?
                $query->whereNotNull($valueField) : $query->whereNotEmpty($valueField);

        static::applyQueryOptions($options, $query);

        // Switch to Illuminate\Database\Eloquent\Builder to use global scopes
        if ($query instanceof QueryBuilder) {
            $query = $this->newQuery()->setQuery($query);
        }

        return $query
            ->distinct($valueField)
            ->select([$valueField . ' AS value', $nameField . ' AS name'])
            ->get();
    }

    /**
     * Access the transformed item's user_ids
     *
     * @return array|string|string[]
     */
    public function getUserIdsAttribute()
    {
        return str_replace(['{', '}'], '', $this->attributes['user_ids']);
    }

    /**
     * Transform and set the item's user_ids
     *
     * @param $value
     * @return void
     */
    public function setUserIdsAttribute($value)
    {
        $this->attributes['user_ids'] = '{' . $value . '}';
    }

    /**
     * Handle dynamic method calls into the model.
     *
     * @param string $method
     * @param array $parameters
     * @return mixed
     */
    public function __call($method, $parameters)
    {
        return
            method_exists($this, $method) ?
                $this->$method(...$parameters) :
                parent::__call($method, $parameters);
    }

    /**
     * Delete the model from the database.
     *
     * @return bool|null|int
     *
     * @throws LogicException
     */
    public function delete()
    {
        $result = parent::delete();

        if ($result && env('DB_SYNC', false) && $this->getConnectionName() == 'pgsql') {
            $result = $this->on('mysql')->toBase()->delete($this->getKey());
        }

        return $result;
    }

    /**
     * Save the model to the database.
     *
     * @param array $options
     * @return bool
     */
    public function save(array $options = []): bool
    {
        $key = $this->getKeyName();

        if (is_null($this->attributes[$key])) {
            unset($this->attributes[$key]);
        }

        $result = parent::save($options);

        if ($result && env('DB_SYNC', false) && $this->getConnectionName() == 'pgsql') {
            $attributes = $this->getAttributes();
            $attributes['user_ids'] = str_replace(['{', '}'], '', $attributes['user_ids']);
            $result = $this->on('mysql')->upsert($attributes, [$this->getKeyName()]);
        }

        return $result;
    }
}
