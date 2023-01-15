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
     * @param array $selectedFilters
     * @return array
     */
    public function getItems(string $skippedField = '',
                             bool   $skip = true,
                             array  $selectedFilters = []): array
    {
        $items = parent::getItems($skippedField, $skip, $selectedFilters);

        array_walk($items['items'], function (&$item) {
            $tmpEmployees = [];

            foreach ($item->employees as $employees) {
                $tmpEmployees = array_merge($tmpEmployees, $employees);
            }

            $item->employees = array_unique($tmpEmployees);
            $item->quantity = count($item->employees);
            $filters = $this->getStaffByMonthFilters($item->year, $item->month);
            $item->modal_items_count = ceil(count($filters['employees']['id']) / session('perPage'));
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

        return [
            'employees' => [
                'id' => array_unique(array_merge(...$employees))
            ]
        ];
    }
}
