<?php

namespace App\Models;


class Employer extends BaseModel
{
    /**
     * @var array
     */
    static $ownSelectOptionsCondtitions = [
        'LEGAL' => 'type_id IN(SELECT id FROM types WHERE name LIKE "%LEGAL%")',
        'FMS' => 'type_id IN(SELECT id FROM types WHERE name LIKE "%FMS%")',
    ];

    /**
     * @var array
     */
    protected $filterFields = [
        'type_id' => ['model' => 'Type',],
    ];

    /**
     * Get all addresses employer has usage permits to.
     */
    public function addresses()
    {
        return $this->belongsToMany(Address::class, 'usage_permits');
    }

    /**
     * Get all employer's usage permits.
     */
    public function usagePermits()
    {
        return $this->hasMany(UsagePermit::class);
    }

    /**
     * Get options for form select.
     * @param array $args
     * @return array
     */
    public static function getOwnSelectOptions(...$args)
    {
        $arg = !$args ? 'LEGAL' : $args[0];
        $options = ['id AS value', 'name_ru AS text'];
        $query = static::whereNotEmpty('name_ru');

        if ($conditions = static::$ownSelectOptionsCondtitions[$arg]) {
            return $query->whereRaw($conditions)->get($options);
        }

        return $query->get($options);
    }
}
