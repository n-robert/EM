<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Carbon\Carbon;
use App\Models\Status;
use Illuminate\Support\Facades\DB;

class StatusSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $statuses = DB::connection('mysql')->table('statuses_source')->get(['id', 'name_ru', 'name_en']);
        Status::truncate();

        foreach ($statuses as $status) {
            Status::insert([
                'id' => $status->id,
                'name_ru' => $status->name_ru,
                'name_en' => $status->name_en,
                'user_ids' => '{2}',
                'created_at' => Carbon::now()
            ]);
        }
    }
}
