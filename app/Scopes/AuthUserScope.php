<?php

namespace App\Scopes;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Scope;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;


class AuthUserScope implements Scope
{
    /**
     * Apply the scope to a given Eloquent query builder.
     *
     * @param Builder $builder
     * @param Model $model
     * @param int|null $id
     * @return void
     */
    public function apply(Builder $builder, Model $model, int $id = null)
    {
        $builder->where(function ($builder) use ($model) {
            $builder->whereJsonContains($model->getTable() . '.user_ids', Auth::id())
                    ->orWhereJsonContains($model->getTable() . '.user_ids', '*');
        });
    }
}
