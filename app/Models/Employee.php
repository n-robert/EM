<?php

namespace App\Models;

use Illuminate\Support\Facades\DB;

class Employee extends BaseModel
{
    /**
     * @var string
     */
    static $defaultName = 'full_name_ru';

    /**
     * @var array
     */
    static $ownSelectOptionsCondtitions = [
        'Officer' => 'status_id = 4',
        'Agent' => 'status_id IN(1, 2)',
        'Director' => 'status_id IN(1, 4)',
        'Booker' => 'status_id = 2',
    ];

    /**
     * @var array
     */
    public $listable = ['id', 'last_name_ru', 'middle_name_ru', 'first_name_ru'];

    /**
     * The base accessors to append to the model's array form.
     *
     * @var array
     */
    static $baseAppends = ['full_name_ru'];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = ['full_name_ru'];

    /**
     * @var array
     */
    protected $defaultOrderBy = ['last_name_ru', 'first_name_ru'];

    /**
     * @var array
     */
    protected $filterFields = [
        'status_id' => ['model' => 'Status',],
        'employer_id' => [
            'model' => 'Employer',
            'whereRaw' => 'employers.type_id IN(SELECT id FROM types WHERE name_ru LIKE "%LEGAL%")',
        ],
        'reg_address_id' => ['model' => 'Address',],
//        'work_permit_paid_till_date' => [],
//        'visa_expired_date' => [],
        'employ_permit_id' => ['model' => 'Permit',],
        'occupation_id' => ['model' => 'Occupation',],
//        'departure_date' => [],
        'citizenship_id' => ['model' => 'Country',],
    ];

    /**
     * Employee constructor.
     *
     * @param  array $attributes
     * @return void
     */
    public function __construct(array $attributes = [])
    {
        parent::__construct($attributes);
    }

    /**
     * Get the employee's russian full name.
     *
     * @return string
     */
    public function getFullNameRuAttribute()
    {
        return implode(' ', array_filter([$this->last_name_ru, $this->first_name_ru, $this->middle_name_ru]));
    }

    /**
     * Get options for form select.
     * @param array $args
     * @return array
     */
    public static function getOwnSelectOptions(...$args)
    {
        $options = [
            'id AS value',
            DB::raw('
                CONCAT(COALESCE(last_name_ru, ""), " ", COALESCE(first_name_ru, ""), " ", COALESCE(middle_name_ru, "")) 
                AS text'
            )
        ];

        if ($args && $conditions = static::$ownSelectOptionsCondtitions[$args[0]]) {
            return static::whereRaw($conditions)->get($options);
        }

        return static::get($options);
    }
}
