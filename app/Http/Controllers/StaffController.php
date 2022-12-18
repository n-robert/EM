<?php

namespace App\Http\Controllers;

use Inertia\Response as InertiaResponse;

class StaffController extends BaseController
{
    /**
     * @var bool
     */
    protected $canCreateNewItem = false;

    /**
     * Show items list.
     *
     * @param string $skippedField
     * @param bool $skip
     * @param array $filters
     * @return array
     */
    public function getItems(string $skippedField = '',
                             bool   $skip = true,
                             array  $filters = []): array
    {
        $items = parent::getItems($skippedField, $skip, $filters);

        array_walk($items['items'], function (&$item) {
            $tmpEmployees = [];

            foreach ($item->employees as $employees) {
                $tmpEmployees = array_merge($tmpEmployees, $employees);
            }

            $item->employees = array_unique($tmpEmployees);
            $item->quantity = count($item->employees);
            $item->modal_items_count = count($this->staffByMonth($item->year, $item->month)['pagination']['links']);
        });

        return $items;
    }

    /**
     * @param $year
     * @param $month
     * @return array
     */
    public function staffByMonth($year, $month): array
    {
        $filters = $this->getStaffByMonthFilters($year, $month);

        return app(EmployeeController::class)->getItems('', true, $filters);
    }

    /**
     * @param $year
     * @param $month
     * @return array[]
     */
    public function getStaffByMonthFilters($year, $month): array
    {
        $employees = $this->model
                ->applyFilters()
                ->where(compact('year', 'month'))
                ->pluck('employees')
                ->all();
        $tmpEmployees = [];

        foreach ($employees as $employee) {
            $tmpEmployees = array_merge($tmpEmployees, $employee);
        }

        return [
            'employees' => [
                'id' => array_unique($tmpEmployees)
            ]
        ];
    }
}
