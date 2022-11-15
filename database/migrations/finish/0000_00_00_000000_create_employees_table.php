<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEmployeesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $columns = [];

        $columns['none'] = [
            'string' => [
                '32' => [
                    'passport_number',
                ],
                '64' => [
                    'last_name_ru',
                    'first_name_ru',
                ],
            ],
            'unsignedBigInteger' => [
                'citizenship_id',
                'status_id',
            ],
            'int_array' => [
                'user_ids',
            ],
        ];

        $columns['default:1'] = [
            'tinyInteger' => [
                'published',
            ],
        ];

        $columns['nullable:true'] = [
            'string' => [
                '32' => [
                    'gender',
                    'passport_serie',
                    'passport_issuer_code',
                    'resident_document_serie',
                    'resident_document_number',
                    'phone',
                    'work_permit_serie',
                    'work_permit_number',
                    'contract_number',
                    'invitation_number',
                    'cert_number',
                    'visa_multiplicity',
                    'visa_category',
                    'visa_serie',
                    'visa_number',
                    'migr_card_serie',
                    'migr_card_number',
                ],
                '64' => [
                    'middle_name_ru',
                    'last_name_en',
                    'first_name_en',
                    'middle_name_en',
                    'entry_checkpoint',
                ],
                '128' => [
                    'passport_issuer',
                    'resident_document',
                    'cert_issuer',
                ],
            ],
            'mediumText' => [
                'birth_place',
                'address',
            ],
            'jsonb' => [
                'history',
            ],
            'date' => [
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
            ],
            'unsignedBigInteger' => [
                'whence_id',
                'employer_id',
                'employ_permit_id',
                'occupation_id',
                'work_address_id',
                'taxpayer_id',
                'host_id',
                'reg_address_id',
                'real_address_id',
                'resident_document_issuer_id',
                'work_permit_issuer_id',
                'visa_issuer_id',
            ],
        ];

        Schema::create('employees', function (Blueprint $table) use ($columns) {
            $table->id();
            add_columns_from_array($columns, $table);
            $table->index(['last_name_ru', 'citizenship_id', 'passport_number']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('employees');
    }
}
