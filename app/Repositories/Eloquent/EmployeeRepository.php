<?php

namespace App\Repositories\Eloquent;

use App\Models\Employee;

class EmployeeRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $defaultOrderBy = ['last_name_ru', 'first_name_ru'];

    /**
     * @var array
     */
    protected $filterFields = [
//        'limited_user',
        'status',
        'employer_id',
        'reg_address',
        'work_permit_paid_till',
        'visa_expired',
        'employ_permit_id',
        'occupation_id',
        'departure_date',
        'citizenship',
    ];

    /**
     * EmployeeRepository constructor.
     *
     * @param Employee $model
     */
    public function __construct(Employee $model)
    {
        parent::__construct($model);
    }

    /**
     * Get filters parameters.
     *
     * @return array
     */
    public function getFilters()
    {
        $filters = parent::getFilters();

        foreach ($this->filterFields as $field) {
            $values = $this->newQuery()->distinct($field)->pluck($field);
            $field = str_replace(['_', 'Id'], '', ucwords($field, '_'));
            $filters[$field] = [];

            foreach($values as $value) {
                $filters[$field][$value] = [];
                $filters[$field][$value]['value'] = $value;
                $filters[$field][$value]['name'] = ucfirst(strtolower($value));
                $filters[$field][$value]['checked'] = session('employee.status.' . $value) ? 'checked' : '';
                $filters[$field][$value]['action'] = $filters[$field][$value]['checked'] ? 'remove' : 'put';
            }
        }

        return $filters;
    }
}