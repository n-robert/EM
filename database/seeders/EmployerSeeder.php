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
            'name_ru',
            'director',
            'booker',
            'taxpayer_id',
            'user_ids',
            'name_ru',
            'full_name_ru',
            'type',
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
            'address',
            'phone',
            'prime_reg_number',
            'history',
            'acc_reg_date',
            'prime_reg_date',
            'uni_reg_date',
        ];

        $oldData = DB::table('robert_fmsdocs_employers')->get();

        foreach ($oldData as $oldDatum) {
            $newData = [];

            foreach ($columns as $column) {
                switch ($column) {
                    case 'created_at':
                        $key = 'created';
                        break;
                    case 'updated_at':
                        $key = 'last_modified';
                        break;
                    default:
                        $key = $column;
                }

                $value = $oldDatum->$key;
                $dateFields = [
                    'acc_reg_date',
                    'prime_reg_date',
                    'uni_reg_date',
                ];
                $constantFields = [
                    'type',
                ];

                if (in_array($column, $dateFields)) {
                    $value = $value == '0000-00-00' ? null : $value;
                }

                if (in_array($column, $constantFields)) {
                    $value = str_replace('COM_FMSDOCS_', '', $value);
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
