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
     * @var string[]
     */
    public $groupBy = [
        'quotas.id',
        'year',
        'employers.name_ru',
    ];

    /**
     * @var array
     */
    public $toSelect = [
        'quotas.id',
        'year',
        'employers.name_ru as employer',
        'quotas.total',
    ];

    /**
     * @var string
     */
    public $toSelectRaw = 'total - sum(quantity) unused_total';

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
        'quotas.employer_id' => [
            'nameModel' => 'Employer',
            ['leftJoin' => 'employers|employers.id|quotas.employer_id'],
            ['leftJoin' => 'types|types.id|employers.type_id'],
            ['whereRaw' => 'types.code LIKE \'%LEGAL%\''],
        ],
        'valid_quotas'       => [
            ['whereRaw' => 'CAST(quotas.year AS INTEGER) >= EXTRACT(YEAR FROM NOW())']
        ],
    ];

    /**
     * Access unused attribute
     *
     * @return array
     */
    public function getUnusedAttribute(): array
    {
        $used = $this::joinSub("select quota_id,
                        (jsonb_array_elements(details)->'occupation_id') occupation_id,
                        (jsonb_array_elements(details)->'quantity')::bigint quantity from permits",
                        'tmp',
                        'tmp.quota_id',
                        'quotas.id',
                        'left')
                     ->whereRaw("tmp.occupation_id IN(
                        select distinct (jsonb_array_elements(details)->'occupation_id') from quotas
                        )")
                     ->where('tmp.quota_id', $this->id)
                     ->groupBy('tmp.occupation_id')
                     ->selectRaw('tmp.occupation_id, sum(quantity)::bigint used')
                     ->pluck('used', 'occupation_id')
                     ->all();
        $unused = [];

        foreach ($this->details as $key => $detail) {
            $unused[$key] = isset($used[$detail['occupation_id']])
                ? $detail['quantity'] - $used[$detail['occupation_id']]
                : $detail['quantity'];
        }

        return $unused;
    }

    /**
     * Scope a query to model's custom clauses.
     *
     * @param Builder $builder
     * @return Builder
     */
    public function scopeApplySelectClauses(Builder $builder): Builder
    {
        $builder
            ->leftJoin('employers', 'employers.id', 'employer_id')
            ->joinSub("select quota_id,
                (jsonb_array_elements(details)->'occupation_id') occupation_id,
                (jsonb_array_elements(details)->'quantity')::bigint quantity from permits",
                'tmp',
                'tmp.quota_id',
                'quotas.id',
                'left'
            )->whereRaw("tmp.occupation_id IN(
                select distinct (jsonb_array_elements(details)->'occupation_id') from quotas
            )");

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
