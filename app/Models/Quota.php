<?php

namespace App\Models;

class Quota extends BaseModel
{
    /**
     * @var string
     */
    static $defaultName = 'year_employer';

    /**
     * @var array
     */
    public $listable = ['id', 'year', 'employer_id', 'issued_date', 'expired_date', 'details'];

    /**
     * Repeatable fields.
     *
     * @var array
     */
    public $repeatable = ['details' => ['country', 'occupation', 'quantity']];

    /**
     * @var array
     */
    protected $defaultOrderBy = ['year'];

    /**
     * Get concatenated name of year and emmployer.
     *
     * @return string
     */
    public function getYearEmployerAttribute()
    {
        return $this->year . ' (' . Employer::find($this->employer_id)->name_ru . ')';
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
}
