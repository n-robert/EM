<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Contracts\Container\BindingResolutionException;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class Permit extends BaseModel
{
    /**
     * @var string
     */
    public static $defaultName = 'number';

    /**
     * @var array
     */
    public static $ownSelectOptionsCondtitions = [
        'Valid' => [
            ['whereRaw' => 'expired_date >= NOW()'],
        ],
    ];

    /**
     * @var array
     */
    public $listable = [
        'permits.id',
        'number',
        'total',
        'expired_date',
        'er.name_ru as employer',
    ];

    /**
     * Repeatable fields.
     *
     * @var array
     */
    public $repeatable = [
        'details' => [
            'country'    => null,
            'occupation' => null,
            'quantity'   => null
        ]
    ];

    /**
     * @var array
     */
    protected $filterFields = [
        'employer_id'   => [
            'model' => 'Employer',
            ['leftJoin' => 'employers|employers.id|permits.employer_id'],
            ['leftJoin' => 'types|types.id|employers.type_id'],
            ['whereRaw' => 'types.code LIKE \'%LEGAL%\''],
        ],
        'valid_permits' => [
            ['whereRaw' => 'permits.expired_date > NOW()']
        ],
    ];

    /**
     * @var array
     */
    protected $defaultOrderBy = ['desc' => 'number'];

    /**
     * Transform details field from JSON
     *
     * @param $value
     * @return mixed
     */
    public function getDetailsAttribute($value)
    {
        return json_decode($value);
    }

    /**
     * Transform details field to JSON
     *
     * @param $value
     * @return void
     */
    public function setDetailsAttribute($value)
    {
        $value = $value ?: [];
        array_walk($value, function ($child, $key) use (&$value) {
            if (!array_sum(array_filter($child))) {
                unset($value[$key]);
            }
        });
        $this->attributes['details'] = json_encode($value);
    }

    /**
     * Calculate the total
     *
     * @return void
     */
    public function setTotalAttribute()
    {
        $details = request('details') ?? [];
        $this->attributes['total'] =
            array_reduce(
                $details,
                function ($carry, $item) {
                    return $carry += $item['quantity'];
                }
            );
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
            ->join('employers as er', 'er.id', '=', 'employer_id', 'left');

        return $builder;
    }

    /**
     * Get own options for form select.
     * @param array $args
     * @return Collection
     * @throws BindingResolutionException
     */
    public function getOwnSelectOptions(...$args): Collection
    {
        $options = ['id AS value', 'number AS text'];
        $query = $this->applyDefaultOrder()->applyAuthUser()->getQuery();

        if ($args && $conditions = static::$ownSelectOptionsCondtitions[$args[0]]) {
            static::applyQueryOptions($conditions, $query);
        }

        return $query->get($options);
    }
}
