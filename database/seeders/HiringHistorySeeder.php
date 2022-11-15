<?php

namespace Database\Seeders;

use App\Models\HiringHistory;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Employee;

class HiringHistorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $columns = [
            'id',
        ];
        $dateColumns = [
            'id',
            'entry_date',
            'hired_date',
            'fired_date',
            'departure_date',
        ];
        $columns = array_merge($columns, $dateColumns);

        HiringHistory::truncate();

        DB::connection('pgsql')->table('employees')->select($columns)->orderBy('id')->chunk(100,
            function ($oldData) use ($dateColumns) {
                foreach ($oldData as $oldDatum) {
                    foreach ($dateColumns as $column) {
                        if ($oldDatum->{$column}) {
                            $newData = [
                                'employee_id' => $oldDatum->id,
                                $column => $oldDatum->{$column},
                            ];

                            HiringHistory::withoutGlobalScopes()->insert($newData);
                        }
                    }
                }
            }
        );
    }
}
