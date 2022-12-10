<?php

namespace Database\Seeders;

use App\Models\Country;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CountrySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $columns = [
            'name_ru',
            'name_en',
            'iso_num',
            'iso_alpha2',
            'iso_alpha3',
            'phone_code',
        ];

        $oldData = DB::connection('mysqlx')->table('fmsdocs_countries')->orderBy('id')->get();
        Country::truncate();

        foreach ($oldData as $oldDatum) {
            $newData = [];

            foreach ($columns as $column) {
                $newData[$column] = $oldDatum->$column;
                $newData['user_ids'] = json_encode(['*']);
                $newData['created_at'] = Carbon::now();
            }

            Country::withoutGlobalScopes()->insert($newData);
        }
    }
}
