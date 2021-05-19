<?php

namespace App\Models;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class Quota extends BaseModel
{
    /**
     * @var string
     */
    static $defaultName = 'year';

    /**
     * @var array
     */
    public $listable = [
        'quotas.id',
        'year',
        'er.name_ru as employer',
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
    protected $defaultOrderBy = ['desc' => 'year'];

    /**
     * @var array
     */
    protected $filterFields = [
        'employer_id'       => [
            'model' => 'Employer',
            ['leftJoin' => 'employers|employers.id|employer_id'],
            ['leftJoin' => 'types|types.id|employers.type_id'],
            ['whereRaw' => 'types.code LIKE \'%LEGAL%\''],
        ],
        'year.valid_quotas' => [
            ['whereRaw' => 'CAST(year AS INT) >= DATE_PART(\'YEAR\', NOW())']
        ],
    ];

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
     * Scope a query to model's custom clauses.
     *
     * @param  \Illuminate\Database\Eloquent\Builder $builder
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeApplyCustomClauses($builder)
    {
        $builder
            ->join('employers as er', 'er.id', '=', 'employer_id', 'left');

        return $builder;
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
}
