<?php

namespace App\Repositories\Eloquent;

use App\Models\Employer;

class EmployerRepository extends BaseRepository
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
     * PermitRepository constructor.
     *
     * @param Employer $model
     */
    public function __construct(Employer $model)
    {
        parent::__construct($model);
    }
}