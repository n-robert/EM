<?php

namespace App\Repositories\Eloquent;

use App\Contracts\RepositoryInterface;
use App\Models\BaseModel;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class BaseRepository implements RepositoryInterface
{
    /**
     * @var BaseModel
     */
    protected $model;

    /**
     * @var string
     */
    protected $name;

    /**
     * @var string
     */
    protected $names;

    /**
     * @var array
     */
    protected $defaultOrderBy = [];

    /**
     * @var array
     */
    protected $filterFields = [];

    /**
     * BaseRepository constructor.
     *
     * @param BaseModel $model
     */
    public function __construct(BaseModel $model)
    {
        $this->model = $model;
        $this->name = strtolower(
            str_replace('Repository', '', class_basename(static::class))
        );
        $this->names = Str::plural($this->name);
    }

    /**
     * Get a new query builder for the model.
     *
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function newQuery()
    {
        $builder = $this->model::query();

        return $builder;
    }

    /**
     * Get an item by id
     * @param int $id
     * @return Model|\Illuminate\Database\Eloquent\Collection
     */
    public function getItem(int $id)
    {
        return $this->newQuery()->findOrFail($id);
    }

    /**
     * Get paginated items
     * @return \Illuminate\Contracts\Pagination\LengthAwarePaginator
     */
    public function getItems()
    {
        return
            $this->applyFilters(
                $this->setDefaultOrderBy(
                    $this->newQuery()
                )
            )->paginate(
                request('perPage')
            );
    }

    /**
     * Apply stored filters to query builder.
     *
     * @param \Illuminate\Database\Eloquent\Builder $builder
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function applyFilters($builder)
    {
        $filters = session($this->names);

        if ($filters && array_filter($filters)) {
            array_walk($filters, function ($value, $key) use ($builder) {
                $builder->whereIn($key, $value);
            });
        }

        return $builder;
    }

    /**
     * Set default order by clause to query builder.
     *
     * @param \Illuminate\Database\Eloquent\Builder $builder
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function setDefaultOrderBy($builder)
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
        return $filters = [];
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
                $this->model->$method(...$parameters);
    }
}