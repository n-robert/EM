<?php

namespace App\Models;

use App\Contracts\ModelInterface;
use App\Services\XmlFormHandlingService;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Collection;
use Illuminate\Support\Str;
use App\Scopes\AuthUserScope;

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
    protected $guarded = ['id', 'user_ids'];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = ['user_ids'];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = ['default_name'];

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
     * @param  array $attributes
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
//        App::bind(ModelInterface::class, static::class);
    }

    /**
     * Get options for a single select.
     *
     * @param string|array $model
     * @param boolean $distinct
     * @return Collection
     */
    public static function getSingleSelectOptions($model, $distinct = true)
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
    public static function getSinglePropertyValue($model, $id)
    {
        if (!is_array($model)) {
            $model = explode(':', $model);
        }

        list($class, $property) = array_pad($model, 2, null);
        $item = call_user_func([__NAMESPACE__ . '\\' . $class, 'find'], $id);

        return $item->{$property};
    }

    /**
     * The "booted" method of the model.
     *
     * @return void
     */
    protected static function booted()
    {
        static::addGlobalScope(new AuthUserScope());
    }

    /**
     * Get options for form select.
     * @return array
     */
    protected static function getOwnSelectOptions()
    {
        $model = app()->make(static::class);

        return
            $model
                ->applyDefaultOrder()
                ->whereNotEmpty(static::$defaultName)
                ->get([$model->getKeyName() . ' AS value', static::$defaultName . ' AS text']);
    }

    /**
     * Scope a query to applied filters.
     *
     * @param  \Illuminate\Database\Eloquent\Builder $builder
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeApplyFilters($builder)
    {
        $filters = session($this->names);

        if ($filters && $filters = array_filter($filters)) {
            array_walk($filters, function ($value, $key) use ($builder) {
                $builder->whereIn($key, $value);
            });
        }

        return $builder;
    }

    /**
     * Scope a query to default order by.
     *
     * @param  \Illuminate\Database\Eloquent\Builder $builder
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeApplyDefaultOrder($builder)
    {
        if ($this->defaultOrderBy) {
            array_map(
                function ($value) use ($builder) {
                    $builder->orderBy($value);
                },
                $this->defaultOrderBy
            );
        }

        return $builder;
    }

    /**
     * Get the model's default name.
     *
     * @return string
     */
    public function getDefaultNameAttribute()
    {
        return
            $this->getAttribute(static::$defaultName) ?:
                call_user_func([$this, 'get' . to_pascal_case(static::$defaultName) . 'Attribute']);
    }

    /**
     * Get pagination data for items
     * @param \Illuminate\Pagination\LengthAwarePaginator $items
     * @return array
     */
    public function getPagination($items)
    {
        $pagination = [];
        $pagination['links'] = $items->toArray()['links'];
        $pagination['previous'] = array_shift($pagination['links']);
        $pagination['next'] = array_pop($pagination['links']);
        $pagination['onFirstPage'] = $items->onFirstPage();
        $pagination['hasPages'] = $items->hasPages();

        return $pagination;
    }

    /**
     * Get filters parameters.
     *
     * @return array
     */
    public function getFilters()
    {
        $filters = [];

        if (!$this->filterFields) {
            return $filters;
        }

        foreach ($this->filterFields as $field => $options) {
            $tmp = $this->names . '.' . $field;
            $items = $this->getFilterFieldItems($field, $options);

            if (!$items) {
                continue;
            }
//            dd($items->all());
//            $component = str_replace(['_', 'Id'], '', ucwords($field, '_'));

            foreach ($items as $item) {
                $item = $item instanceof Model ? $item->getAttributes() : (array)$item;
                $value = $item['value'];
                $key = $tmp . '.' . $value;

                $filters[$field][$value] = $item;
                $filters[$field][$value]['field'] = $field;
                $filters[$field][$value]['checked'] = session($key) ? 'checked' : '';
                $filters[$field][$value]['action'] = session($key) ? 'remove' : 'put';
            }
        }
//        dd($filters);
        return $filters;
    }

    /**
     * @param string $field
     * @return Collection
     */
    public function getFilterFieldItems($field, $options)
    {
        $valueField = $this->names . '.' . $field;
        $query = $this->distinct($valueField);
        $query =
            str_ends_with($field, '_date') ?
                $query->whereNotNull($valueField) :
                $query->whereNotEmpty($valueField);

        if (isset($options['model'])) {
            $model = app()->make(__NAMESPACE__ . '\\' . $options['model']);
            $table = $model->names;
            $nameField = $table . '.' . $model::$defaultName;
            $query =
                $query
                    ->leftJoin($table, $table . '.id', '=', $valueField)
                    ->whereNotEmpty($nameField);
        } else {
            $table = $this->names;
            $nameField = $table . '.' . $field;
        }

        if (isset($options['whereRaw'])) {
            $query = $query->whereRaw($options['whereRaw']);
        }

        $query = $query->select([$valueField . ' AS value', $nameField . ' AS name']);

        return $items = $query->get();
    }

    /**
     * Handle dynamic method calls into the model.
     *
     * @param  string $method
     * @param  array $parameters
     * @return mixed
     */
    public function __call($method, $parameters)
    {
        return
            method_exists($this, $method) ?
                $this->$method(...$parameters) :
                parent::__call($method, $parameters);
    }
}
