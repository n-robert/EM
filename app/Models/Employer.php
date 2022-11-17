<?php

namespace App\Models;


use Illuminate\Contracts\Container\BindingResolutionException;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class Employer extends BaseModel
{
    /**
     * @var array
     */
    public static $ownSelectOptionsCondtitions = [
        'LEGAL' => [
            ['leftJoin' => 'types|types.id|type_id'],
            ['whereRaw' => 'types.code LIKE \'%LEGAL%\''],
        ],
        'FMS'   => [
            ['leftJoin' => 'types|types.id|type_id'],
            ['whereRaw' => 'types.code LIKE \'%FMS%\''],
        ],
    ];

    /**
     * @var array
     */
    public $listable = [
        'employers.id',
        'name_ru',
        'full_name_ru',
        't.code as type',
    ];

    /**
     * @var array
     */
    protected $filterFields = [
        'type_id' => [
            'model' => 'Type',
            ['leftJoin' => 'types|types.id|type_id'],
        ],
    ];

    /**
     * Get options for form select.
     * @param array $args
     * @return Collection
     * @throws BindingResolutionException
     */
    public function getOwnSelectOptions(...$args): Collection
    {
        $args = $args ?: ['LEGAL'];
        $options = ['employers.id AS value', 'name_ru AS text'];
        $query = $this->applyDefaultOrder()->applyAuthUser()->getQuery();

        if ($args && $conditions = static::$ownSelectOptionsCondtitions[$args[0]]) {
            static::applyQueryOptions($conditions, $query);
        }

        return $query->get($options);
    }

    /**
     * Get all addresses employer has usage permits to.
     */
    public function addresses(): BelongsToMany
    {
        return $this->belongsToMany(Address::class, 'usage_permits');
    }

    /**
     * Get all employer's usage permits.
     */
    public function usagePermits(): HasMany
    {
        return $this->hasMany(UsagePermit::class);
    }

    /**
     * Scope a query to model's custom clauses.
     *
     * @param Builder $builder
     * @return Builder
     */
    public function scopeApplyCustomClauses(Builder $builder): Builder
    {
        $builder
            ->join('types as t', 't.id', '=', 'type_id', 'left');

        return $builder;
    }
}
