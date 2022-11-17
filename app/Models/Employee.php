<?php

namespace App\Models;

use Illuminate\Contracts\Container\BindingResolutionException;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class Employee extends BaseModel
{
    /**
     * @var string
     */
    public static $defaultName = 'full_name_ru';

    /**
     * @var array
     */
    public static $ownSelectOptionsCondtitions = [
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
        'work_permit_expired_date',
        'o.name_ru as occupation',
        's.name_ru as status',
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
        'status_id' => [
            'model' => 'Status',
            ['leftJoin' => 'statuses|statuses.id|status_id'],
        ],

        'employer_id' => [
            'model' => 'Employer',
            ['leftJoin' => 'employers|employers.id|employer_id'],
            ['leftJoin' => 'types|types.id|employers.type_id'],
            ['whereRaw' => 'types.code LIKE \'%LEGAL%\''],
        ],

        'reg_address_id' => [
            'model' => 'Address',
            ['leftJoin' => 'addresses|addresses.id|reg_address_id'],
        ],

        'employ_permit_id' => [
            'model' => 'Permit',
            ['leftJoin' => 'permits|permits.id|employ_permit_id'],
            ['whereRaw' => 'permits.expired_date >= NOW()'],
        ],

        'occupation_id' => [
            'model' => 'Occupation',
            ['leftJoin' => 'occupations|occupations.id|occupation_id'],
        ],

        'citizenship_id' => [
            'model' => 'Country',
            ['leftJoin' => 'countries|countries.id|citizenship_id'],
        ],
    ];

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
        return implode(' ', array_filter([$this->last_name_ru, $this->first_name_ru, $this->middle_name_ru]));
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

        if ($args && $conditions = static::$ownSelectOptionsCondtitions[$args[0]]) {
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
    public function scopeApplyCustomClauses(Builder $builder): Builder
    {
        $builder
            ->join('occupations as o', 'o.id', '=', 'occupation_id', 'left')
            ->join('statuses as s', 's.id', '=', 'status_id', 'left');

        return $builder;
    }
}
