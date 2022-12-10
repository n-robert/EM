<?php

namespace Database\Seeders;

use App\Models\EmployeeJob;
use App\Models\EmployeeTurnover;
use Carbon\Carbon;
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
            'work_address_id',
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
        $employeeTurnoverColumns = [
            'entry_date'     => $statuses['Arrived'],
            'hired_date'     => $statuses['Hired'],
            'fired_date'     => $statuses['Fired'],
            'departure_date' => $statuses['Left'],
        ];
        $employeeJobColumns = [
            'employer_id',
            'contract_number',
            'occupation_id',
            'work_address_id',
            'hired_date',
            'fired_date',
        ];

        Employee::truncate();
        EmployeeJob::truncate();
        EmployeeTurnover::truncate();

        DB::connection('mysqlx')->table('fmsdocs_employees')->orderBy('id')->chunk(100,
            function ($oldData) use (
                $columns,
                $changedColumns,
                $statuses,
                $employeeTurnoverColumns,
                $employeeJobColumns
            ) {
                foreach ($oldData as $oldDatum) {
                    // New employees table's row
                    $newEmployeeData = [];
                    // New employee_job table's row
                    $newEmployeeJobData = [];
                    $newEmployeeJobData['employee_id'] = $oldDatum->id;

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
                            $value =
                                in_array($value, ['0000-00-00'], '0000-00-00 00:00:00') ?
                                    null :
                                    Carbon::parse($value)->isoFormat('YYYY-MM-DD');
                        }

                        if ($column == 'status_id') {
                            $value = str_replace(
                                ['family', 'furlough', 'worker'],
                                ['family member', 'on leave', 'hired'],
                                strtolower($value)
                            );
                            $value = $statuses[ucfirst($value)];
                        }

                        if (str_ends_with($column, '_id')) {
                            $value = intval($value);
                        }

                        if ($column == 'user_ids') {
                            $value = json_encode(array_map(
                                function ($item) {
                                    return (int)str_replace(
                                        ['208', '209', '211', '214', '215'],
                                        [2, 3, 2, 4, 5],
                                        trim($item)
                                    );
                                },
                                explode(',', $value)
                            ));
                            // employee_job table's user_ids column
                            $newEmployeeJobData['user_ids'] = $value;
                        }

                        if ($column == 'history') {
                            $oldValue = json_decode($value);

                            if (!empty($oldValue->date)) {
                                $newValue = [];

                                foreach ($oldValue->date as $k => $date) {
                                    $prevValue = [];
                                    $tmp = explode(chr(10), $oldValue->prev_value[$k]);
                                    array_walk($tmp, function ($item) use (&$prevValue, $changedColumns, $dateFields) {
                                        $item = explode(': ', $item);

                                        if (count($item) == 2) {
                                            list($k, $v) = $item;

                                            if ($k != 'user_ids') {
                                                foreach ($changedColumns as $column) {
                                                    if (str_starts_with($column, trim($k))) {
                                                        $k = $column;
                                                        break;
                                                    }
                                                }

                                                if (in_array($k, $dateFields)) {
                                                    $v =
                                                        in_array($v, ['0000-00-00'], '0000-00-00 00:00:00') ?
                                                            null :
                                                            Carbon::parse($v)->isoFormat('YYYY-MM-DD');
                                                }

                                                $prevValue[$k] = $v;
                                            }
                                        }
                                    });
                                    $user = preg_replace('~^#(\d+)\s.+~', '$1', $oldValue->user[$k]);
                                    $newValue[] = [
                                        'date'       => Carbon::parse($date)->isoFormat('YYYY-MM-DD H:m:s'),
                                        'prev_value' => $prevValue,
                                        'user'       => $user,
                                    ];
                                }

                                $value = json_encode($newValue);
                            }
                        }

                        $newEmployeeData[$column] = $value;
                    }

                    $tmpData = $newEmployeeData;

                    foreach ($employeeJobColumns as $jobColumn) {
                        // Add columns to new employee_job table's row
                        $newEmployeeJobData[$jobColumn] = $tmpData[$jobColumn];
                        // Remove columns from new employees table's row
                        unset($newEmployeeData[$jobColumn]);
                    }

                    // Save new employees table's row
                    Employee::withoutGlobalScopes()->insert($newEmployeeData);

                    foreach ($employeeTurnoverColumns as $dateColumn => $status) {
                        if ($tmpData[$dateColumn]) {
                            // New employee_turnover table's row
                            $newEmployeeTurnoverData = [
                                'employee_id' => $tmpData['id'],
                                'employer_id' => $tmpData['employer_id'],
                                'date'        => $tmpData[$dateColumn],
                                'status_id'   => $status,
                                'user_ids'    => $tmpData['user_ids'],
                            ];

                            // Save new employee_turnover table's row
                            EmployeeTurnover::withoutGlobalScopes()->insert($newEmployeeTurnoverData);
                        }
                    }

                    // Save new employee_job table's row
                    if ($newEmployeeJobData['employer_id']) {
                        EmployeeJob::withoutGlobalScopes()->insert($newEmployeeJobData);
                    }
                }
            }
        );
    }
}
