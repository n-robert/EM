<?php

namespace App\Repositories\Eloquent;

use App\Models\Country;

class CountryRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $defaultOrderBy = ['name_ru'];

    /**
     * @var array
     */
    protected $filterFields = [
//        'limited_user',
    ];

    /**
     * EmployeeRepository constructor.
     *
     * @param Country $model
     */
    public function __construct(Country $model)
    {
        parent::__construct($model);
    }
}