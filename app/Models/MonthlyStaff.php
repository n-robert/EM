<?php

namespace App\Models;

class MonthlyStaff extends BaseModel
{
    /**
     * @var bool
     */
    public $hasHistory = false;

    /**
     * @var array
     */
    protected $casts = [
        'employees'  => 'array',
        'user_ids' => 'array',
    ];

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'monthly_staff';
}
