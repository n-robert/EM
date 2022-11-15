<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Quota;

class QuotaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $columns = [
            'year',
            'employer_id',
            'issued_date',
            'expired_date',
            'details',
            'user_ids',
            'published',
            'history',
        ];

        $oldData = DB::connection('mysqlx')->table('fmsdocs_quotas')->get();
        Quota::truncate();

        foreach ($oldData as $oldDatum) {
            $newData = [];

            foreach ($columns as $column) {
                switch ($column) {
                    case 'issued_date':
                        $key = 'issued';
                        break;
                    case 'expired_date':
                        $key = 'expired';
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

                $value = $oldDatum->$key;

                $dateFields = [
                    'issued_date',
                    'expired_date',
                ];

                if (in_array($column, $dateFields)) {
                    $value = $value == '0000-00-00' ? null : $value;
                }

                if ($column == 'user_ids') {
                    $value = '{' . str_replace(['208', '209', '211', '214', '215'], [2, 3, 2, 4, 5], $value) . '}';
                }

                if (str_ends_with($column, '_id')) {
                    $value = intval($value);
                }

                if ($column == 'details') {
                    $newValue = [];
                    $value = json_decode($value);

                    if ($value) {
                        foreach ($value->country as $key => $country) {
                            $tmpObj = new \stdClass();
                            $tmpObj->country_id = $country;
                            $tmpObj->occupation_id = $value->occupation[$key];
                            $tmpObj->quantity = $value->quantity[$key];
                            $newValue[] = $tmpObj;
                        }
                    }

                    $value = json_encode($newValue);
                }

                if ($column == 'history') {
                    $oldValue = json_decode($value);

                    if (!empty($oldValue['date'])) {
                        $newValue = [];

                        foreach ($oldValue['date'] as $k => $date) {
                            $newValue[] = [
                                'date' => $date,
                                'prev_value' => $oldValue['prev_value'][$k],
                                'user' => $oldValue['user'][$k],
                            ];
                        }

                        $value = json_encode($newValue);
                    }
                }

                $newData[$column] = $value;
            }

            $newData['total'] =
                array_reduce(
                    json_decode($newData['details']),
                    function ($carry, $item) {
                        return $carry += $item->quantity;
                    }
                );

            Quota::withoutGlobalScopes()->insert($newData);
        }
    }
}
