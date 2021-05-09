<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Address;

class AddressSeeder extends Seeder
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
            'ownership_certificate',
            'description',
            'user_ids',
            'published',
            'history',
        ];

        $oldData = DB::table('robert_fmsdocs_addresses')->get();

        foreach ($oldData as $oldDatum) {
            $newData = [];

            foreach ($columns as $column) {
                switch ($column) {
                    case 'status_id':
                        $key = 'status';
                        break;
                    case 'created_at':
                        $key = 'created';
                        break;
                    case 'updated_at':
                        $key = 'last_modified';
                        break;
                    default:
                        $key = $column;
                }

                $newData[$column] = $oldDatum->$key;
            }

            Address::insert($newData);
        }
    }
}
