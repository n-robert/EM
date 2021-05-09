<?php

namespace App\Repositories\Eloquent;

use App\Models\Status;

class StatusRepository extends BaseRepository
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
    public function __construct(Status $model)
    {
        parent::__construct($model);
    }
}