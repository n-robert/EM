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
                    'citizenship',
                    'passport_number',
                    'status_id',
                    'user_ids',
                ],
                '64' => [
                    'last_name_ru',
                    'first_name_ru',
                ],
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
                    'whence',
                    'passport_serie',
                    'passport_issuer_code',
                    'resident_document_serie',
                    'resident_document_number',
                    'phone',
                    'employer_id',
                    'employ_permit_id',
                    'work_permit_serie',
                    'work_permit_number',
                    'occupation_id',
                    'work_address',
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
                    'resident_document_issuer',
                    'work_permit_issuer',
                    'cert_issuer',
                    'visa_issuer',
                ],
            ],
            'mediumText' => [
                'birth_place',
                'address',
            ],
            'text' => [
                'history',
            ],
            'date' => [
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
            ],
        ];

        Schema::create('employees', function (Blueprint $table) use ($columns) {
            $table->id();
            add_columns_from_array($columns, $table);
            $table->index(['last_name_ru', 'citizenship', 'passport_number']);
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
