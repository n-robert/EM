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
            13 => 'entry_date',
            12 => 'hired_date',
            7  => 'fired_date',
            9  => 'departure_date',
        ];
        $columns = array_merge($columns, $dateColumns);

        HiringHistory::truncate();

        DB::connection('pgsql')->table('employees')->select($columns)->orderBy('id')->chunk(100,
            function ($oldData) use ($dateColumns) {
                foreach ($oldData as $oldDatum) {
                    foreach ($dateColumns as $status => $dateColumn) {
                        if ($oldDatum->{$dateColumn}) {
                            $newData = [
                                'employee_id' => $oldDatum->id,
                                'date'        => $oldDatum->{$dateColumn},
                                'status_id'   => $status,
                                'user_ids'    => '{}',
                            ];

                            HiringHistory::withoutGlobalScopes()->insert($newData);
                        }
                    }
                }
            }
        );
    }
}
