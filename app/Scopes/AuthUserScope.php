<?php

namespace App\Scopes;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Scope;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;


class AuthUserScope implements Scope
{
    /**
     * Apply the scope to a given Eloquent query builder.
     *
     * @param  \Illuminate\Database\Eloquent\Builder  $builder
     * @param  \Illuminate\Database\Eloquent\Model  $model
     * @return void
     */
    public function apply(Builder $builder, Model $model)
    {
        $user = Auth::user();
        $connection = DB::connection()->getName();

        if (Gate::allows('is-admin') || $connection == 'mysqlx') {
            return;
        }

        if ($connection == 'pgsql') {
            $builder->whereRaw($user->id . ' = ANY(' . $model->getTable() . '.user_ids)');
        } else {
            $builder->whereRaw('FIND_IN_SET(' . $user->id . ', ' . $model->getTable() . '.user_ids)');
        }
    }
}
