<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\UsagePermit;

class UsagePermitSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
//        $columns = [
//            'id',
//            'user_ids',
//            'name_ru',
//            'address_id',
//            'employer_id',
//            'signing_date',
//            'history',
//            'created_at',
//            'updated_at',
//        ];
//
//        $oldData = DB::connection('mysql')->table('usage_permits')->get();
        UsagePermit::truncate();

//        foreach ($oldData as $oldDatum) {
//            $newData = [];
//
//            foreach ($columns as $column) {
//                $value = $oldDatum->$column;
//
//                if ($column == 'user_ids') {
//                    $value = '{' . str_replace(['208', '209', '211', '214', '215'], [2, 3, 2, 4, 5], $value) . '}';
//                }
//
//                if (str_ends_with($column, '_id')) {
//                    $value = intval($value);
//                }
//
//                $newData[$column] = $value;
//            }
//
//            UsagePermit::insert($newData);
//        }
    }
}
