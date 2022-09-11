<?php

namespace App\Repositories\Eloquent;

use App\Models\Occupation;

class OccupationRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $defaultOrderBy = ['number'];

    /**
     * @var array
     */
    protected $filterFields = [
//        'limited_user',
    ];

    /**
     * OccupationRepository constructor.
     *
     * @param Occupation $model
     */
    public function __construct(Occupation $model)
    {
        parent::__construct($model);
    }
}