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

        foreach ($items['items'] as $item) {
            $item->modal_items_count = count($this->staffByMonth($item->year, $item->month)['pagination']['links']);
        }

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

        return [
            'employees' => [
                'id' => $ids
            ]
        ];
    }
}
