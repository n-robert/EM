<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Employee;

class EmployeeSeeder extends Seeder
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
            'passport_number',
            'user_ids',
            'last_name_ru',
            'first_name_ru',
            'birth_date',
            'published',
            'gender',
            'passport_serie',
            'passport_issuer',
            'passport_issuer_code',
            'resident_document_serie',
            'resident_document_number',
            'phone',
            'employer_id',
            'employ_permit_id',
            'work_permit_serie',
            'work_permit_number',
            'occupation_id',
            'contract_number',
            'taxpayer_id',
            'invitation_number',
            'cert_number',
            'visa_multiplicity',
            'visa_category',
            'visa_serie',
            'visa_number',
            'migr_card_serie',
            'migr_card_number',
            'middle_name_ru',
            'last_name_en',
            'first_name_en',
            'middle_name_en',
            'entry_checkpoint',
            'resident_document',
            'cert_issuer',
            'birth_place',
            'address',
            'history',
            'hired_date',
            'fired_date',
            'entry_date',
            'reg_date',
            'departure_date',
        ];

        $changedColumns = [
            'citizenship_id',
            'status_id',
            'whence_id',
            'reg_address_id',
            'real_address_id',
            'host_id',
            'resident_document_issuer_id',
            'work_permit_issuer_id',
            'visa_issuer_id',
            'passport_issued_date',
            'passport_expired_date',
            'resident_document_issued_date',
            'resident_document_expired_date',
            'work_permit_issued_date',
            'work_permit_started_date',
            'work_permit_expired_date',
            'work_permit_paid_till_date',
            'taxpayer_id_issued_date',
            'cert_issued_date',
            'visa_issued_date',
            'visa_started_date',
            'visa_expired_date',
            'migr_card_issued_date',
        ];

        $columns = array_merge($columns, $changedColumns);
        $statuses = DB::connection('pgsql')->table('statuses')->pluck('id', 'name_en');

        Employee::truncate();

        DB::connection('mysqlx')->table('fmsdocs_employees')->orderBy('id')->chunk(100,
            function ($oldData) use ($columns, $changedColumns, $statuses) {
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

                        if (in_array($column, $changedColumns)) {
                            $key = preg_replace('~^(.+)(_id|_date)$~', '$1', $key);
                        }

                        $value = str_replace('COM_FMSDOCS_', '', $oldDatum->{$key});

                        $dateFields = [
                            'birth_date',
                            'passport_issued_date',
                            'passport_expired_date',
                            'resident_document_issued_date',
                            'resident_document_expired_date',
                            'work_permit_issued_date',
                            'work_permit_started_date',
                            'work_permit_expired_date',
                            'work_permit_paid_till_date',
                            'hired_date',
                            'fired_date',
                            'taxpayer_id_issued_date',
                            'cert_issued_date',
                            'visa_issued_date',
                            'visa_started_date',
                            'visa_expired_date',
                            'entry_date',
                            'migr_card_issued_date',
                            'reg_date',
                            'departure_date',
                        ];

                        if (in_array($column, $dateFields)) {
                            $value = $value == '0000-00-00' ? null : $value;
                        }

                        if ($column == 'status_id') {
                            $value = str_replace(
                                ['family', 'furlough', 'worker'],
                                ['family member', 'on leave', 'hired'],
                                strtolower($value)
                            );
                            $value = $statuses[ucfirst($value)];
                        }

                        if ($column == 'user_ids') {
                            $value =
                                '{' . str_replace(['208', '209', '211', '214', '215'], [2, 3, 2, 4, 5], $value) . '}';
                        }

                        if (str_ends_with($column, '_id')) {
                            $value = intval($value);
                        }

                        if ($column == 'history') {
                            $oldValue = json_decode($value);

                            if (!empty($oldValue->date)) {
                                $newValue = [];

                                foreach ($oldValue->date as $k => $date) {
                                    $prevValue = [];
                                    $tmp = explode(chr(10), $oldValue->prev_value[$k]);
                                    array_walk($tmp, function ($item) use (&$prevValue) {
                                        $item = explode(': ', $item);

                                        if (count($item) == 2) {
                                            list($k, $v) = $item;

                                            if ($k != 'user_ids') {
                                                $prevValue[$k] = $v;
                                            }
                                        }
                                    });
                                    $user = preg_replace('~^#(\d+)\s.+~', '$1', $oldValue->user[$k]);
                                    $newValue[] = [
                                        'date' => $date,
                                        'prev_value' => $prevValue,
                                        'user' => $user,
                                    ];
                                }

                                $value = json_encode($newValue);
                            }
                        }

                        $newData[$column] = $value;
                    }

                    Employee::withoutGlobalScopes()->insert($newData);
                }
            }
        );
    }
}
