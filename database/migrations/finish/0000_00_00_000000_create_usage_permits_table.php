<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsagePermitsTable extends Migration
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
                '64' => [
                    'name_ru',
                ],
            ],
            'jsonb' => [
                'user_ids',    // previous type - int_array
            ],
        ];

        $columns['nullable:true'] = [
            'string' => [
            ],
            'date'   => [
                'signing_date',
            ],
            'jsonb'   => [
                'history',
            ],
            'unsignedBigInteger' => [
                'address_id',
                'employer_id',
            ],
        ];

        Schema::create(
            'usage_permits',
            function (Blueprint $table) use ($columns) {
                $table->id();
                add_columns_from_array($columns, $table);
                $table->timestamps();
                $table->foreign('address_id')
                      ->references('id')
                      ->on('addresses')->onDelete('cascade');
            }
        );
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('usage_permits');
    }
}
