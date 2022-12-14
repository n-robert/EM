<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;

class Staff extends BaseModel
{
    /**
     * @var string
     */
    public static $defaultName = 'staff';

    /**
     * @var bool
     */
    public $hasHistory = false;

    /**
     * @var array
     */
    public $listable = [
        "tmp.year",
        "tmp.month",
    ];

    /**
     * @var array
     */
    public $listableRaw = "count(employee) as staff, '/staff/'||tmp.year||'/'||tmp.month as item_custom_link";

    /**
     * @var array
     */
    protected $casts = [
        'employees' => 'array',
        'user_ids'  => 'array',
    ];

    /**
     * @var array
     */
    protected $defaultOrderBy = ['tmp.year', 'tmp.month'];

    /**
     * @var array
     */
    protected $filterFields = [
        'staff.employer_id' => [
            'nameModel' => 'Employer',
            ['leftJoin' => 'employers|employers.id|staff.employer_id'],
            ['leftJoin' => 'types|types.id|employers.type_id'],
            ['whereRaw' => 'types.code LIKE \'%LEGAL%\''],
        ],
    ];

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'staff';

    /**
     * Scope a query to model's custom clauses.
     *
     * @param Builder $builder
     * @return Builder
     */
    public function scopeApplyOwnQueryClauses(Builder $builder): Builder
    {
        $builder
            ->joinSub(
                'select year, month, employer_id, cast(jsonb_array_elements(employees) as integer) as employee from staff',
                'tmp',
                'tmp.employer_id',
                '=',
                'staff.employer_id',
                'right',
            )
            ->groupBy($this->listable);

        return $builder;
    }
}
