<?php

namespace App\Contracts;

use Illuminate\Database\Eloquent\Builder;

interface  RepositoryInterface
{
    /**
     * Get a new query builder for the model.
     *
     * @return Builder
     */
    public function newQuery();

    /**
     * Handle dynamic method calls into the model.
     *
     * @param  string $method
     * @param  array $parameters
     * @return mixed
     */
    public function __call($method, $parameters);
}