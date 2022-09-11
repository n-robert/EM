<?php

namespace App\Repositories\Eloquent;

use App\Models\Quota;

class QuotaRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $defaultOrderBy = ['year'];

    /**
     * @var array
     */
    protected $filterFields = [
//        'limited_user',
    ];

    /**
     * EmployeeRepository constructor.
     *
     * @param Quota $model
     */
    public function __construct(Quota $model)
    {
        parent::__construct($model);
    }
}