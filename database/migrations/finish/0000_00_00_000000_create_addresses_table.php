<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAddressesTable extends Migration
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
                ],
            ],
            'jsonb' => [
                    'user_ids',    // previous type - int_array
            ],
        ];

        $columns['nullable:true'] = [
            'string' => [
                '512' => [
                    'description',
                ],
            ],
            'jsonb' => [
                'history',
            ],
        ];

        Schema::create('addresses', function (Blueprint $table) use ($columns) {
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
        Schema::dropIfExists('addresses');
    }
}
