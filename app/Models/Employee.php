<?php

namespace App\Models;

use App\Http\Requests\EmployeeRequestValidation;
use Illuminate\Contracts\Container\BindingResolutionException;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use stdClass;

class Employee extends BaseModel
{
    /**
     * @var string
     */
    public static $defaultName = 'full_name_ru';

    /**
     * @var array
     */
    public static $ownSelectOptionsConditions = [
        'Officer'  => [
            ['leftJoin' => 'statuses|statuses.id|status_id'],
            ['where' => 'statuses.name_en|Official'],
        ],
        'Agent'    => [
            ['leftJoin' => 'statuses|statuses.id|status_id'],
            ['whereRaw' => 'statuses.name_en IN(\'Boss\', \'Booker\')'],
        ],
        'Director' => [
            ['leftJoin' => 'statuses|statuses.id|status_id'],
            ['whereRaw' => 'statuses.name_en IN(\'Boss\', \'Booker\', \'Official\', \'Client\')'],
        ],
        'Booker'   => [
            ['leftJoin' => 'statuses|statuses.id|status_id'],
            ['whereRaw' => 'statuses.name_en IN(\'Boss\', \'Booker\')'],
        ],
    ];

    /**
     * @var array
     */
    public $listable = [
        'employees.id',
        'last_name_ru',
        'middle_name_ru',
        'first_name_ru',
        'statuses.name_ru as status',
        'occupations.name_ru as occupation',
        'work_permit_expired_date',
    ];

    /**
     * Repeatable fields.
     *
     * @var array
     */
    public $repeatable = [
        'employee_job' => [
            'id'              => null,
            'employer_id'     => null,
            'occupation_id'   => null,
            'work_address_id' => null,
            'contract_number' => null,
            'hired_date'      => null,
            'fired_date'      => null,
        ]
    ];

    /**
     * @var array
     */
    protected $defaultOrderBy = [
        'last_name_ru',
        'first_name_ru',
    ];

    /**
     * @var array
     */
    protected $filterFields = [
        'employees.status_id' => [
            'nameModel' => 'Status',
            ['leftJoin' => 'statuses|statuses.id|employees.status_id'],
        ],

        'employee_job.employer_id' => [
            'model'     => 'EmployeeJob',
            'nameModel' => 'Employer',
            ['leftJoin' => 'employers|employers.id|employee_job.employer_id'],
            ['leftJoin' => 'types|types.id|employers.type_id'],
            ['whereRaw' => 'types.code LIKE \'%LEGAL%\''],
        ],

        'employees.reg_address_id' => [
            'nameModel' => 'Address',
            ['leftJoin' => 'addresses|addresses.id|employees.reg_address_id'],
        ],

        'employees.employ_permit_id' => [
            'nameModel' => 'Permit',
            ['leftJoin' => 'permits|permits.id|employees.employ_permit_id'],
            ['whereRaw' => 'permits.expired_date >= NOW()'],
        ],

        'employee_job.occupation_id' => [
            'model'     => 'EmployeeJob',
            'nameModel' => 'Occupation',
            ['leftJoin' => 'occupations|occupations.id|employee_job.occupation_id'],
        ],

        'employees.citizenship_id' => [
            'nameModel' => 'Country',
            ['leftJoin' => 'countries|countries.id|employees.citizenship_id'],
        ],
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = ['employee_job', 'last_job'];

    /**
     * Get the employee's full name in English
     *
     * @return string
     */
    public function getFullNameEnAttribute(): string
    {
        return implode(' ', array_filter([$this->last_name_en, $this->first_name_en, $this->middle_name_en]));
    }

    /**
     * Get the employee's full name in Russian
     *
     * @return string
     */
    public function getFullNameRuAttribute(): string
    {
        return implode(' ',
            array_filter([
                $this->last_name_ru,
                $this->first_name_ru,
                $this->middle_name_ru
            ])
        );
    }

    /**
     * Get the employee's jobs.
     *
     * @return Collection
     */
    public function getEmployeeJobAttribute(): Collection
    {
        return
            DB::table('employee_job')
              ->where(['employee_id' => $this->id])
              ->orderBy('hired_date')
              ->get([
                  'id',
                  'employer_id',
                  'occupation_id',
                  'work_address_id',
                  'contract_number',
                  'hired_date',
                  'fired_date'
              ]);
    }

    /**
     * Get the employee's last job.
     *
     * @return stdClass|null
     */
    public function getLastJobAttribute(): ?stdClass
    {
        if ($jobs = $this->employee_job->all()) {
            return $jobs[count($jobs) - 1];
        }

        return null;
    }

    /**
     * Get options for form select.
     * @param array $args
     * @return Collection
     * @throws BindingResolutionException
     */
    public function getOwnSelectOptions(...$args): Collection
    {
        $options = [
            'employees.id AS value',
            DB::raw('
                CONCAT(COALESCE(last_name_ru, \'\'), \' \', COALESCE(first_name_ru, \'\'), \' \', COALESCE(middle_name_ru, \'\'))
                AS text'
            )
        ];
        $query = $this->applyDefaultOrder()->applyAuthUser()->getQuery();

        if ($args && $conditions = static::$ownSelectOptionsConditions[$args[0]]) {
            static::applyQueryOptions($conditions, $query);
        }

        return $query->get($options);
    }

    /**
     * Scope a query to model's custom clauses.
     *
     * @param Builder $builder
     * @return Builder
     */
    public function scopeApplyOwnQueryClauses(Builder $builder): Builder
    {
        $listable = array_map(
            function ($column) {
                return explode(' ', $column)[0];
            },
            $this->listable
        );
        $builder
            ->join('employee_job', 'employee_job.employee_id', '=', 'employees.id', 'left')
            ->join('occupations', 'occupations.id', '=', 'employee_job.occupation_id', 'left')
            ->join('statuses', 'statuses.id', '=', 'employees.status_id', 'left')
            ->groupBy($listable);

        return $builder;
    }

    /**
     * Get all employee's employers.
     *
     * @return BelongsToMany
     */
    public function employers(): BelongsToMany
    {
        return $this->belongsToMany(Employer::class, 'employee_job');
    }

    /**
     * Get all statuses that employee has changed.
     *
     * @return BelongsToMany
     */
    public function statuses(): BelongsToMany
    {
        return $this->belongsToMany(Status::class, 'employee_turnover');
    }

    /**
     * Save the model to the database.
     *
     * @param array $options
     * @return bool
     */
    public function save(array $options = []): bool
    {
        if (parent::save($options)) {
            $request = request()->except('type');
            $statuses = Status::pluck('id', 'name_en');
            $employee_job = $request['employee_job'] ?? [];
            $employeeStatusColumns = [
                'entry_date'     => $statuses['Arrived'],
                'hired_date'     => $statuses['Hired'],
                'fired_date'     => $statuses['Fired'],
                'departure_date' => $statuses['Left'],
            ];
            $newEmployeeTurnoverData = [];

            // Save employee_job data
            if ($employee_job) {
                array_map(function ($job) {
                    $EmployeeJobModel = $job['id'] ? EmployeeJob::find($job['id']) : new EmployeeJob();
                    $EmployeeJobModel->setAttribute('employee_id', $this->id);
                    $EmployeeJobModel->fill($job)->save();
                }, $employee_job);
            }

            foreach ($employeeStatusColumns as $dateColumn => $status) {
                // Get arrived_date and departure_date
                if (isset($request[$dateColumn]) && $request[$dateColumn]) {
                    $newEmployeeTurnoverData[] = [
                        'employee_id' => $this->id,
                        'date'        => $request[$dateColumn],
                        'status_id'   => $status,
                        'user_ids'    => $this->user_ids,
                    ];
                }

                // Get hired_date and fired_date
                if ($employee_job) {
                    array_map(function ($job) use ($dateColumn, $status, &$newEmployeeTurnoverData) {
                        if (isset($job[$dateColumn]) && $job[$dateColumn]) {
                            $newEmployeeTurnoverData[] = [
                                'employee_id' => $this->id,
                                'employer_id' => $job['employer_id'],
                                'date'        => $job[$dateColumn],
                                'status_id'   => $status,
                                'user_ids'    => $this->user_ids,
                            ];
                        }
                    }, $employee_job);
                }
            }

            if ($newEmployeeTurnoverData) {
                foreach ($newEmployeeTurnoverData as $datum) {
                    $test = $datum;
                    unset($test['user_ids']);

                    if (!MonthlyStaff::query()->where($test)->first()) {
                        (new MonthlyStaff())->fill($datum)->save();
                    }
                }
            }

            return true;
        }

        return false;
    }
}
