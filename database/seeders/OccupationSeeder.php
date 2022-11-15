<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Occupation;

class OccupationSeeder extends Seeder
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
            'name_ru',
            'code',
            'description',
            'user_ids',
            'published',
            'history',
        ];

        $oldData = DB::connection('mysqlx')->table('fmsdocs_occupations')->get();
        Occupation::truncate();

        foreach ($oldData as $oldDatum) {
            $newData = [];

            foreach ($columns as $column) {
                switch ($column) {
                    case 'name_ru':
                        $key = 'name';
                        break;
                    default:
                        $key = $column;
                }

                $value = $oldDatum->{$key};

                if ($column == 'user_ids') {
                    $value = '{' . str_replace(['208', '209', '211', '214', '215'], [2, 3, 2, 4, 5], $value) . '}';
                }

                if (str_ends_with($column, '_id')) {
                    $value = intval($value);
                }

                if ($column == 'history') {
                    $oldValue = json_decode($value);

                    if (!empty($oldValue->date)) {
                        $newValue = [];

                        foreach ($oldValue->date as $k => $date) {
                            $newValue[] = [
                                'date' => $date,
                                'prev_value' => $oldValue->prev_value[$k],
                                'user' => $oldValue->user[$k],
                            ];
                        }

                        $value = json_encode($newValue);
                    }
                }

                $newData[$column] = $value;
                $newData['created_at'] = Carbon::now()->format('Y-m-d H:i:s');
                $newData['updated_at'] = Carbon::now()->format('Y-m-d H:i:s');
            }

            Occupation::withoutGlobalScopes()->insert($newData);
        }
    }
}
