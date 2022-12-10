<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCountriesTable extends Migration
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
                    'name_en',
                ],
            ],
            'jsonb' => [
                'user_ids',    // previous type - int_array
            ],
        ];

        $columns['nullable:true'] = [
            'char' => [
                '2' => [
                    'iso_alpha2',
                ],
                '3' => [
                    'iso_alpha3',
                ],
            ],
            'bigInteger' => [
                'iso_num',
                'phone_code',
            ],
        ];

        Schema::create('countries', function (Blueprint $table) use ($columns) {
            $table->id();
            add_columns_from_array($columns, $table);
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
        Schema::dropIfExists('countries');
    }
}
