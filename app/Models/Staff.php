<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;

class Staff extends BaseModel
{
    /**
     * @var bool
     */
    public static $adminOnly = true;

    /**
     * @var bool
     */
    public $hasHistory = false;

    /**
     * @var array
     */
    public $listable = [
        'year',
        'month',
    ];

    /**
     * @var array
     */
    public $listableRaw =
        "jsonb_agg(employees) as employees,
        '/staff/'||year||'/'||month as item_custom_link,
        1 as no_link";

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
    protected $defaultOrderBy = ['year', 'month'];

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
     * The attributes that aren't mass assignable.
     *
     * @var array|bool
     */
    protected $guarded = [];

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'staff';

    /**
     * Get the model's default name.
     *
     * @return string|null
     */
    public function getDefaultNameAttribute(): ?string
    {
        return $this->year. $this->month;
    }

    /**
     * Scope a query to model's custom clauses.
     *
     * @param Builder $builder
     * @return Builder
     */
    public function scopeApplyOwnQueryClauses(Builder $builder): Builder
    {
        $builder
            ->groupBy($this->listable);

        return $builder;
    }
}
