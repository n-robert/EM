<?php

namespace App\Repositories\Eloquent;

use App\Models\Address;

class AddressRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $defaultOrderBy = ['name'];

    /**
     * @var array
     */
    protected $filterFields = [
//        'limited_user',
    ];

    /**
     * EmployeeRepository constructor.
     *
     * @param Status $model
     */
    public function __construct(Address $model)
    {
        parent::__construct($model);
    }
}