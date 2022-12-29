<?php

namespace App\Models;

use App\Http\Requests\EmployeeRequestValidation;
use Carbon\Carbon;
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
    public static $selfSelectOptionsConditions = [
        'Officer'  => [
            ['leftJoin' => 'statuses|statuses.id|status_id'],
            ['where' => 'statuses.name_en|Official'],
        ],
        'Boss'    => [
            ['leftJoin' => 'statuses|statuses.id|status_id'],
            ['where' => 'statuses.name_en|Boss'],
        ],
        'Director' => [
            ['leftJoin' => 'statuses|statuses.id|status_id'],
            ['whereRaw' => 'statuses.name_en IN(\'Boss\', \'Official\', \'Client\')'],
        ],
    ];

    /**
     * @var string[]
     */
    public $groupBy = [
        'employees.id',
        'last_name_ru',
        'middle_name_ru',
        'first_name_ru',
        'statuses.name_ru',
        'occupations.name_ru',
        'work_permit_expired_date',
    ];

    /**
     * @var array
     */
    public $toSelect = [
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

        'employees.visa_expired_date' => [
            'nameModel' => 'Employee',
            ['whereRaw' => 'employees.visa_expired_date >= NOW()'],
        ],

        'employees.permit_id' => [
            'nameModel' => 'Permit',
            ['leftJoin' => 'permits|permits.id|employees.permit_id'],
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
    public function getSelfSelectOptions(...$args): Collection
    {
        $options = [
            'employees.id AS value',
            DB::raw('
                CONCAT(COALESCE(last_name_ru, \'\'), \' \', COALESCE(first_name_ru, \'\'), \' \', COALESCE(middle_name_ru, \'\'))
                AS text'
            )
        ];
        $query = $this->applyDefaultOrder()->applyAuthUser()->getQuery();

        if ($args && $conditions = static::$selfSelectOptionsConditions[$args[0]]) {
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
    public function scopeApplySelectClauses(Builder $builder): Builder
    {
        $builder
            ->leftJoin('employee_job', 'employee_job.employee_id', 'employees.id')
            ->leftJoin('occupations', 'occupations.id', 'employee_job.occupation_id')
            ->leftJoin('statuses', 'statuses.id', 'employees.status_id');

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
            $jobData = $request['employee_job'] ?? [];
            $dateTypeStatus = [
                'entry_date'     => $statuses['Arrived'],
                'hired_date'     => $statuses['Hired'],
                'fired_date'     => $statuses['Fired'],
                'departure_date' => $statuses['Left'],
            ];
            $turnoverData = [];

            // Save employee_job data
            if ($jobData) {
                array_map(function ($job) {
                    $employeeJobModel = $job['id'] ? EmployeeJob::find($job['id']) : new EmployeeJob();
                    $employeeJobModel->setAttribute('employee_id', $this->id);
                    $employeeJobModel->fill($job)->save();
                }, $jobData);
            }

            foreach ($dateTypeStatus as $dateType => $status) {
                // Get arrived_date and departure_date
                if (isset($request[$dateType]) && $request[$dateType]) {
                    $turnoverData[] = [
                        'employee_id' => $this->id,
                        'date'        => $request[$dateType],
                        'status_id'   => $status,
                    ];
                }

                // Get hired_date and fired_date
                if ($jobData) {
                    array_map(function ($job) use ($request, $dateType, $status, &$turnoverData) {
                        if (isset($job[$dateType]) && $job[$dateType]) {
                            $turnoverData[] = [
                                'employee_id' => $this->id,
                                'employer_id' => $job['employer_id'],
                                'date'        => $job[$dateType],
                                'status_id'   => $status,
                            ];

                            // Add new employee to current month staff
                            if ($dateType == 'hired_date' && $request['status_id'] == $status) {
                                $year = Carbon::now()->isoFormat('YYYY');
                                $month = Carbon::now()->isoFormat('MM');
                                $employerId = $job['employer_id'];
                                $staffModel =
                                    Staff::withoutGlobalScopes()
                                         ->where([
                                             'year'  => $year,
                                             'month' => $month,
                                             'employer_id' => $employerId,
                                         ])
                                         ->first() ?? new Staff();

                                $employees = $staffModel->employees ?? [];
                                $employees[] = $this->id;

                                $staffModel
                                    ->fill([
                                        'year'      => $year,
                                        'month'     => $month,
                                        'employer_id' => $employerId,
                                        'employees' => array_unique($employees),
                                        'user_ids'  => Employer::find($employerId)->user_ids,
                                    ])
                                    ->save();
                            }
                        }
                    }, $jobData);
                }
            }

            if ($turnoverData) {
                foreach ($turnoverData as $datum) {
                    $test = $datum;
                    unset($test['user_ids']);

                    if (!EmployeeTurnover::query()->where($test)->first()) {
                        (new EmployeeTurnover())->fill($datum)->save();
                    }
                }
            }

            return true;
        }

        return false;
    }
}
