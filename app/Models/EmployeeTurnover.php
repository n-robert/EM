<?php

namespace App\Models;

class EmployeeTurnover extends BaseModel
{
    /**
     * @var bool
     */
    public $hasHistory = false;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'employee_turnover';
}
