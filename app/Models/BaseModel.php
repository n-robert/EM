<?php

namespace App\Models;

use App\Contracts\ModelInterface;
use Carbon\Carbon;
use Illuminate\Contracts\Container\BindingResolutionException;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Query\Builder as QueryBuilder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Str;
use App\Scopes\AuthUserScope;

class BaseModel extends Model implements ModelInterface
{
    use HasFactory;

    /**
     * @var string
     */
    public static $defaultName = 'name_ru';

    /**
     * @var array
     */
    public static $ownSelectOptionsConditions = [];

    /**
     * The base accessors to append to the model's array form.
     *
     * @var array
     */
    public static $baseAppends = ['default_name'];

    /**
     * @var bool
     */
    public static $skipAuthUserScope = false;

    /**
     * Apply additional options to query
     *
     * @param array $options
     * @param mixed $query
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
                $query = in_array($method, ['model', 'nameModel']) ? $query : $query->$method(...$args);
            });
        }
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
     * @var bool
     */
    public $hasHistory = true;

    /**
     * @var array
     */
    public $listable = ['*'];

    /**
     * @var array
     */
    public $listableRaw = '';

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
     * @var array
     */
    protected $casts = [
        'history'  => 'array',
        'user_ids' => 'array',
    ];

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
            !app()->runningInConsole()
            && in_array($this->name, session('views'))
            && url()->current() == route('gets.' . $this->names)
        ) {
            $this->appends = [];
        }

        $this->appends = array_merge($this->appends, static::$baseAppends);
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
     * @param Builder $builder
     * @return Builder
     */
    public function scopeApplyAuthUser(Builder $builder): Builder
    {
        if (!Gate::allows('is-admin') && !static::$skipAuthUserScope) {
            $builder->where(function ($builder) {
                $builder->whereJsonContains($this->getTable() . '.user_ids', Auth::id())
                        ->orWhereJsonContains($this->getTable() . '.user_ids', '*');
            });
        }

        return $builder;
    }

    /**
     * Scope a query to model's custom clauses.
     *
     * @param Builder $builder
     * @return Builder
     */
    public function scopeApplyOwnQueryClauses(Builder $builder): Builder
    {
        return $builder;
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
     * Scope a query to applied filters.
     *
     * @param Builder $builder
     * @return Builder
     * @throws BindingResolutionException
     */
    public function scopeApplyFilters(Builder $builder): Builder
    {
        $filters = session($this->names . '.filters');

        if ($filters && $filters = array_filter($filters)) {
            $this->applyFiltersRecursive($filters, $builder);
        }

        return $builder;
    }

    /**
     * Get the model's default name.
     *
     * @return string|null
     */
    public function getDefaultNameAttribute(): ?string
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
            $link['url'] = app('url')->to($link['url']);
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
     * @param string $skippedField
     * @return array
     * @throws BindingResolutionException
     */
    public function getFilters(bool $skip = true, string $skippedField = ''): array
    {
        $filters = [];

        if (!$this->filterFields || !array_filter($this->filterFields)) {
            return $filters;
        }

        foreach ($this->filterFields as $field => $options) {
            $tmpKey = $this->names . '.filters.' . $field;
            // If field has no model, then we will assume that filter is simplified
            // and just store query clause in session
            if (!isset($options['nameModel'])) {
                session([$this->names . '.queries.' . $this->names . '.' . $field => $options]);

                $key = $tmpKey;
                $filters[$field][$field]['name'] = $field;
                $filters[$field][$field]['value'] = $field;
                $filters[$field][$field]['field'] = $field;
                $filters[$field][$field]['checked'] = session($key) ? 'checked' : '';
                $filters[$field][$field]['action'] = session($key) ? 'remove' : 'put';

                continue;
            }

            if (!$items = $this->getFilterFieldItems($field, $options, $skip, $skippedField)) {
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
     * @param string $skippedField
     * @return Collection
     * @throws BindingResolutionException
     */
    public function getFilterFieldItems(string $field,
                                        array  $options,
                                        bool   $skip = true,
                                        string $skippedField = ''): Collection
    {
        if (isset($options['model'])) {
            $model = app()->make(__NAMESPACE__ . '\\' . $options['model']);
            unset($options['model']);
        } else {
            $model = new static();
        }

        $valueField = $nameField = strpos($field, '.') ? $field : $model->getTable() . '.' . $field;

        if (isset($options['nameModel'])) {
            $nameModel = app()->make(__NAMESPACE__ . '\\' . $options['nameModel']);
            $nameField = $nameModel->getTable() . '.' . $nameModel::$defaultName;
            unset($options['nameModel']);
        }

        // Determine whether to skip dynamic applying other fields filters when getting this field items
        $query = ($skip || $field == $skippedField) ? $model : $model::applyFilters();
        $query =
            str_ends_with($field, '_date') ?
                $query->whereNotNull($valueField) : $query->whereNotEmpty($valueField);

        static::applyQueryOptions($options, $query);

        // Switch to Illuminate\Database\Eloquent\Builder to use global scopes
        if ($query instanceof QueryBuilder) {
            $query = $model->newQuery()->setQuery($query);
        }

        return $query
            ->distinct($valueField)
            ->select([$valueField . ' AS value', $nameField . ' AS name'])
            ->get();
    }

    /**
     * Save the model to the database.
     *
     * @param array $options
     * @return bool
     */
    public function save(array $options = []): bool
    {
        foreach ($this->attributes as $key => $attribute) {
            if (is_null($attribute)) {
                unset($this->attributes[$key]);
            }
        }

        if (!$this->user_ids) {
            $this->setAttribute('user_ids', session('user_ids'));
        }

        if ($this->hasHistory && $id = $this->getAttribute($this->getKeyName())) {
            $existing = $this->make()->find($id);
            $history = $existing['history'];
            $prev = [];

            if ($existing) {
                foreach ($existing->attributes as $k => $v) {
                    $actual = $this->getAttribute($k);

                    if (
                        !in_array($k, ['user_ids', 'history', 'created_at', 'updated_at'])
                        && !is_null($actual)
                        && $actual != $v
                    ) {
                        $prev[$k] = $v;
                    }
                }
            }

            if ($prev) {
                $history[] = [
                    'date'       => Carbon::now()->isoFormat('YYYY-MM-DD H:m:s'),
                    'user'       => Auth::id(),
                    'prev_value' => $prev,
                ];
                $this->setAttribute('history', $history);
            }
        }

        return parent::save($options);
    }

    /**
     * Get options for form select.
     * @return Collection
     * @throws BindingResolutionException
     */
    protected function getOwnSelectOptions(): Collection
    {
        return
            $this->applyDefaultOrder()
                 ->applyAuthUser()
                 ->getQuery()
                 ->whereNotEmpty(static::$defaultName)
                 ->get([$this->getKeyName() . ' AS value', static::$defaultName . ' AS text']);
    }

    /**
     * Traverse filters array recursively to apply them
     *
     * @param $filters
     * @param $builder
     * @param string $table
     * @throws BindingResolutionException
     */
    protected function applyFiltersRecursive($filters, $builder, string $table = '')
    {
//        dd($filters);
        array_walk($filters, function ($value, $key) use ($builder, $table) {
            if (count($value) != count($value, COUNT_RECURSIVE)) {
                $key = $table ? $table . '.' . $key : $key;
                $this->applyFiltersRecursive($value, $builder, $key);
            } else {
                $table = $table ?: $this->names;
                // If there is a simplified filter, then we just apply its original options to query
                // Otherwise we will apply the "where... IN" clause to query
                if ($options = session($this->names . '.queries.' . $table . '.' . $key)) {
                    static::applyQueryOptions($options, $builder);
                } elseif ($value = array_filter($value)) {
                    $builder->whereIn($table . '.' . $key, $value);
                }
            }
        });
    }
}
