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
    public static $ownSelectOptionsConditions = [
        'Valid' => [
            ['whereRaw' => 'expired_date >= NOW()'],
        ],
    ];

    /**
     * @var string[]
     */
    public $groupBy = [
        'permits.id',
        'number',
        'employers.name_ru',
    ];

    /**
     * @var array
     */
    public $toSelect = [
        'permits.id',
        'number',
        'total',
        'expired_date',
        'employers.name_ru as employer',
    ];

    /**
     * @var string
     */
    public $toSelectRaw = 'total - count(employee_job.occupation_id) unused_total';

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
    protected $defaultOrderBy = ['desc' => 'number'];

    /**
     * @var array
     */
    protected $filterFields = [
        'permits.employer_id' => [
            'nameModel' => 'Employer',
            ['leftJoin' => 'employers|employers.id|permits.employer_id'],
            ['leftJoin' => 'types|types.id|employers.type_id'],
            ['whereRaw' => 'types.code LIKE \'%LEGAL%\''],
        ],
        'valid_permits'       => [
            ['whereRaw' => 'permits.expired_date > NOW()']
        ],
    ];

    /**
     * Access unused attribute
     *
     * @return array
     */
    public function getUnusedAttribute(): array
    {
        $used = EmployeeJob::query()
                           ->leftJoin('employees', 'employees.id', 'employee_job.employee_id')
                           ->leftJoin('statuses', 'statuses.id', 'employees.status_id')
                           ->where('statuses.name_en', '<>', 'Cancelled')
                           ->where('employees.permit_id', $this->id)
                           ->groupBy('occupation_id')
                           ->selectRaw('count(occupation_id) used, occupation_id')
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
     * Mutate the total attribute
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
    public function scopeApplySelectClauses(Builder $builder): Builder
    {
        $builder
            ->leftJoin('employers', 'employers.id', 'employer_id')
            ->leftJoin('employees', 'employees.permit_id', 'permits.id')
            ->leftJoin('employee_job', 'employee_job.employee_id', 'employees.id')
            ->leftJoin('statuses', 'statuses.id', 'employees.status_id')
            ->where('statuses.name_en', '<>', 'Cancelled');

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

        if ($args && $conditions = static::$ownSelectOptionsConditions[$args[0]]) {
            static::applyQueryOptions($conditions, $query);
        }

        return $query->get($options);
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
        array_walk($details, function (&$child, $key) use (&$value) {
            array_walk($child, function (&$element) {
                $element = (int)$element;
            });

            if (!array_sum(array_filter($child))) {
                unset($value[$key]);
            }
        });
        $this->setAttribute('details', $details);

        $issuedDate = request('issued_date');
        $year = Carbon::parse($issuedDate)->isoFormat('YYYY');
        $employerId = request('employer_id');
        $quotaId = Quota::where(['year' => $year, 'employer_id' => $employerId])->first()->id;
        $this->setAttribute('quota_id', (int)$quotaId);

        return parent::save($options);
    }
}
