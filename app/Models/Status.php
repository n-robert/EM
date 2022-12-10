<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Status extends BaseModel
{
    /**
     * @var bool
     */
    public static $skipAuthUserScope = true;

    /**
     * Get all employees that has changed status.
     *
     * @return BelongsToMany
     */
    public function employees(): BelongsToMany
    {
        return $this->belongsToMany(Employee::class, 'employee_history');
    }
}
