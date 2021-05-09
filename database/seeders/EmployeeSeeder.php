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
            'citizenship',
            'passport_number',
            'status_id',
            'user_ids',
            'last_name_ru',
            'first_name_ru',
            'birth_date',
            'passport_issued',
            'passport_expired',
            'published',
            'gender',
            'whence',
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
            'host',
            'reg_address',
            'real_address',
            'middle_name_ru',
            'last_name_en',
            'first_name_en',
            'middle_name_en',
            'entry_checkpoint',
            'resident_document',
            'resident_document_issuer',
            'work_permit_issuer',
            'cert_issuer',
            'visa_issuer',
            'birth_place',
            'address',
            'history',
            'resident_document_issued',
            'resident_document_expired',
            'work_permit_issued',
            'work_permit_started',
            'work_permit_expired',
            'work_permit_paid_till',
            'hired_date',
            'fired_date',
            'taxpayer_id_issued',
            'cert_issued',
            'visa_issued',
            'visa_started',
            'visa_expired',
            'entry_date',
            'migr_card_issued',
            'reg_date',
            'departure_date',
        ];

        $oldData = DB::table('robert_fmsdocs_employees')->get();
        $statuses = DB::table('statuses')->pluck('id', 'name_ru');

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

                $value = $oldDatum->$key;
                $dateFields = [
                    'birth_date',
                    'passport_issued',
                    'passport_expired',
                    'resident_document_issued',
                    'resident_document_expired',
                    'work_permit_issued',
                    'work_permit_started',
                    'work_permit_expired',
                    'work_permit_paid_till',
                    'hired_date',
                    'fired_date',
                    'taxpayer_id_issued',
                    'cert_issued',
                    'visa_issued',
                    'visa_started',
                    'visa_expired',
                    'entry_date',
                    'migr_card_issued',
                    'reg_date',
                    'departure_date',
                ];
                $constantFields = [
                    'status_id',
                    'gender',
                    'visa_multiplicity',
                    'visa_category',
                    'history',
                ];

                if (in_array($column, $dateFields)) {
                    $value = $value == '0000-00-00' ? null : $value;
                }

                if (in_array($column, $constantFields)) {
                    $value = str_replace('COM_FMSDOCS_', '', $value);

                    if ($column == 'status_id') {
                        $value = $statuses[$value];
                    }
                }

                if ($column == 'user_ids') {
                    $value = str_replace(['208', '209', '214', '215'], ['2', '3', '4', '5'], $value);
                }

                $newData[$column] = $value;
            }

            Employee::insert($newData);
        }
    }
}
