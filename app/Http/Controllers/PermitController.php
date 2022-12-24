<?php

namespace App\Http\Controllers;

use App\Models\EmployeeJob;

class PermitController extends BaseController
{
    /**
     * Get item data.
     *
     * @param int|string $id
     * @return array
     */
    public function getItem($id): array
    {
        $item = parent::getItem($id);
        $details = $item['item']->details;
        $unused = $item['item']->unused;

        foreach ($details as $key => $detail) {
            $details[$key]['unused'] = $unused[$key];
        }

        $item['item']->details = $details;

        return $item;
    }
}
