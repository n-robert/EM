<?php

namespace App\Http\Controllers;

class StaffController extends BaseController
{
    /**
     * @var bool
     */
    protected $canCreateNewItem = false;

    public function staffByMonth($year, $month)
    {
        $ids = array_map(
            function ($item) {
                return $item->employee_id;
            },
            $this->model
                ->applyFilters()
                ->selectRaw('cast(jsonb_array_elements(employees) as integer) as employee_id')
                ->where(compact('year', 'month'))
                ->get()
                ->all()
        );
        $filters = [
            'employees' => [
                'id' => $ids
            ]
        ];

        return app(EmployeeController::class)->showAll('', true, $filters);
    }
}
