<?php

namespace App\Models;


class Employer extends BaseModel
{
    /**
     * @var array
     */
    static $ownSelectOptionsCondtitions = [
        'LEGAL' => [
            ['leftJoin' => 'types|types.id|type_id'],
            ['whereRaw' => 'types.code LIKE \'%LEGAL%\''],
        ],
        'FMS'   => [
            ['leftJoin' => 'types|types.id|type_id'],
            ['whereRaw' => 'types.code LIKE \'%FMS%\''],
        ],
    ];

    /**
     * @var array
     */
    public $listable = [
        'employers.id',
        'name_ru',
        'full_name_ru',
        't.code as type',
    ];

    /**
     * @var array
     */
    protected $filterFields = [
        'type_id' => [
            'model' => 'Type',
            ['leftJoin' => 'types|types.id|type_id'],
        ],
    ];

    /**
     * Get options for form select.
     * @param array $args
     * @return array
     */
    public static function getOwnSelectOptions(...$args)
    {
        $args = $args ?: ['LEGAL'];
        $options = ['employers.id AS value', 'name_ru AS text'];
        $query = static::query()->whereNotEmpty('name_ru');

        if ($conditions = static::$ownSelectOptionsCondtitions[$args[0]]) {
            static::applyQueryOptions($conditions, $query);
        }

        return $query->get($options);
    }

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
     * Scope a query to model's custom clauses.
     *
     * @param  \Illuminate\Database\Eloquent\Builder $builder
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeApplyCustomClauses($builder)
    {
        $builder
            ->join('types as t', 't.id', '=', 'type_id', 'left');

        return $builder;
    }
}
