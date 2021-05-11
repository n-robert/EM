<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Employer;

class EmployerSeeder extends Seeder
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
            'taxpayer_id',
            'user_ids',
            'published',
            'taxpayer_code',
            'active_business_type',
            'rcoad',
            'bcc',
            'acc_book_number',
            'account_number',
            'bank',
            'ca',
            'bic',
            'acc_reg_number',
            'uni_reg_number',
            'phone',
            'prime_reg_number',
            'history',
            'acc_reg_date',
            'prime_reg_date',
            'uni_reg_date',
        ];

        $changedColumns = [
            'name_ru',
            'full_name_ru',
            'director_id',
            'booker_id',
            'type_id',
            'address_id',
        ];
        $columns = array_merge($columns, $changedColumns);
        $oldData = DB::connection('mysqlextra')->table('fmsdocs_employers')->get();
        $types = DB::table('types')->pluck('id', 'name');

        foreach ($oldData as $oldDatum) {
            $newData = [];

            foreach ($columns as $column) {
                switch ($column) {
                    case 'name_ru':
                        $key = 'name';
                        break;
                    case 'full_name_ru':
                        $key = 'full_name';
                        break;
                    case 'director_id':
                        $key = 'director';
                        break;
                    case 'booker_id':
                        $key = 'booker';
                        break;
                    case 'type_id':
                        $key = 'type';
                        break;
                    case 'address_id':
                        $key = 'address';
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

                $value = str_replace('COM_FMSDOCS_', '', $oldDatum->$key);
                $dateFields = [
                    'acc_reg_date',
                    'prime_reg_date',
                    'uni_reg_date',
                ];

                if (in_array($column, $dateFields)) {
                    $value = $value == '0000-00-00' ? null : $value;
                }

                if ($column == 'type_id') {
                    $value = $types[$value];
                }

                if ($column == 'user_ids') {
                    $value = str_replace(['208', '209', '214', '215'], ['2', '3', '4', '5'], $value);
                }

                $newData[$column] = $value;
            }

            Employer::insert($newData);
        }
    }
}
