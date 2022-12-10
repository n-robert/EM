<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Permit;

class PermitSeeder extends Seeder
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
            'number',
            'issued_date',
            'expired_date',
            'employer_id',
            'quota_id',
            'details',
            'user_ids',
            'history',
        ];

        $oldData = DB::connection('mysqlx')->table('fmsdocs_permits')->get();
        Permit::truncate();

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
                    $value =
                        in_array($value, ['0000-00-00'], '0000-00-00 00:00:00') ?
                            null :
                            Carbon::parse($value)->isoFormat('YYYY-MM-DD');
                }

                if ($column == 'user_ids') {
                    $value = json_encode(array_map(
                        function ($item) {
                            return (int)str_replace(['208', '209', '211', '214', '215'], [2, 3, 2, 4, 5], trim($item));
                        },
                        explode(',', $value)
                    ));
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

                    if (!empty($oldValue->date)) {
                        $newValue = [];

                        foreach ($oldValue->date as $k => $date) {
                            $prevValue = [];
                            $tmp = explode(chr(10), $oldValue->prev_value[$k]);
                            array_walk($tmp, function ($item) use (&$prevValue, $dateFields) {
                                $item = explode(': ', $item);

                                if (count($item) == 2) {
                                    list($k, $v) = $item;

                                    if ($k != 'user_ids') {
                                        foreach ($dateFields as $column) {
                                            if (str_starts_with($column, $k)) {
                                                $k = $column;
                                                $v =
                                                    in_array($v, ['0000-00-00'], '0000-00-00 00:00:00') ?
                                                        null :
                                                        Carbon::parse($v)->isoFormat('YYYY-MM-DD');
                                                break;
                                            }
                                        }

                                        $prevValue[$k] = $v;
                                    }
                                }
                            });
                            $user = preg_replace('~^#(\d+)\s.+~', '$1', $oldValue->user[$k]);
                            $newValue[] = [
                                'date' => Carbon::parse($date)->isoFormat('YYYY-MM-DD H:m:s'),
                                'prev_value' => $prevValue,
                                'user' => $user,
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

            Permit::withoutGlobalScopes()->insert($newData);
        }
    }
}
