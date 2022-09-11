<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEmployersTable extends Migration
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
                '512' => [
                    'name_ru',
                    'full_name_ru',
                ],
            ],
            'unsignedBigInteger' => [
                'director_id',
                'user_ids',
                'type_id',
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
                ],
            ],
            'text' => [
                'history',
            ],
            'date' => [
                'acc_reg_date',
                'prime_reg_date',
                'uni_reg_date',
            ],
            'unsignedBigInteger' => [
                'booker_id',
                'taxpayer_id',
                'address_id',
            ],
        ];

        Schema::create('employers', function (Blueprint $table) use ($columns) {
            $table->id();
            add_columns_from_array($columns, $table);
            $table->unique(['name_ru', 'taxpayer_id']);
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
        Schema::dropIfExists('employers');
    }
}
