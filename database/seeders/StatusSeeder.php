<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Carbon\Carbon;
use App\Models\Status;
use App\Models\Employee;

class StatusSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $statuses =
            Employee::withoutGlobalScopes()
                ->distinct('status_id')
                ->whereNotNull('status_id')
                ->pluck('status_id');

        foreach ($statuses as $status) {
            Status::insert(['name_ru' => $status, 'user_ids' => '2', 'created_at' => Carbon::now()]);
        }
    }
}
