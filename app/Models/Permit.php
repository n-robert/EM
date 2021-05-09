<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Support\Collection;

class Permit extends BaseModel
{
    /**
     * @var string
     */
    static $defaultName = 'number';

    /**
     * @var array
     */
    static $ownSelectOptionsCondtitions = [
        'Valid' => 'expired_date > CURDATE()',
    ];

    /**
     * @var array
     */
    public $listable = ['id', 'number', 'employer_id', 'quota_id', 'issued_date', 'expired_date', 'details'];

    /**
     * Repeatable fields.
     *
     * @var array
     */
    public $repeatable = ['details' => ['country', 'occupation', 'number']];

    /**
     * @var array
     */
    protected $filterFields = [
        'employer_id' => [
            'model' => 'Employer',
            'whereRaw' =>'employers.type_id IN(SELECT id FROM types WHERE name_ru LIKE "%LEGAL%")',
        ],
//        'expired_date' => ['whereRaw' => 'expired_date > NOW()'],
    ];

    /**
     * @var array
     */
    protected $defaultOrderBy = ['number'];

    /**
     * Employee constructor.
     *
     * @param  array $attributes
     * @return void
     */
    public function __construct(array $attributes = [])
    {
        parent::__construct($attributes);
    }

    /**
     * Transform details field from JSON
     *
     * @param $value
     * @return mixed
     */
    public function getDetailsAttribute($value)
    {
        return json_decode($value);
    }

    /**
     * Transform details field to JSON
     *
     * @param $value
     * @return void
     */
    public function setDetailsAttribute($value)
    {
        array_walk($value, function ($child, $key) use(&$value) {
            if (!array_sum(array_filter($child))) {
                unset($value[$key]);
            }
        });
        $this->attributes['details'] = json_encode($value);
    }

    /**
     * Get own options for form select.
     * @param array $args
     * @return array
     */
    public static function getOwnSelectOptions(...$args)
    {
        $options = ['id AS value', 'number AS text'];
        $query = app()->make(static::class)->whereNotEmpty('number');

        if ($args && $conditions = static::$ownSelectOptionsCondtitions[$args[0]]) {
            return $query->whereRaw($conditions)->get($options);
        }

        return $query->get($options);
    }
}
