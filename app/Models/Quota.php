<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class Quota extends BaseModel
{
    /**
     * @var string
     */
    public static $defaultName = 'year';

    /**
     * @var array
     */
    public $listable = [
        'quotas.id',
        'year',
        'employers.name_ru as employer',
        'total',
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
    protected $casts = [
        'details'  => 'array',
        'history'  => 'array',
        'user_ids' => 'array',
    ];

    /**
     * @var array
     */
    protected $defaultOrderBy = ['desc' => 'year'];

    /**
     * @var array
     */
    protected $filterFields = [
        'quotas.employer_id'       => [
            'nameModel' => 'Employer',
            ['leftJoin' => 'employers|employers.id|quotas.employer_id'],
            ['leftJoin' => 'types|types.id|employers.type_id'],
            ['whereRaw' => 'types.code LIKE \'%LEGAL%\''],
        ],
        'valid_quotas' => [
            ['whereRaw' => 'CAST(quotas.year AS INTEGER) >= EXTRACT(YEAR FROM NOW())']
        ],
    ];

    /**
     * Scope a query to model's custom clauses.
     *
     * @param Builder $builder
     * @return Builder
     */
    public function scopeApplyItemsClauses(Builder $builder): Builder
    {
        $builder
            ->join('employers', 'employers.id', '=', 'employer_id', 'left');

        return $builder;
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
     * Save the model to the database.
     *
     * @param array $options
     * @return bool
     */
    public function save(array $options = []): bool
    {
        $details = request('details') ?? [];
        array_walk($details, function ($child, $key) use (&$value) {
            if (!array_sum(array_filter($child))) {
                unset($value[$key]);
            }
        });
        $this->setAttribute('details', $details);

        return parent::save($options);
    }
}
