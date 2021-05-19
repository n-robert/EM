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
            'unsignedBigInteger' => [
                'user_ids',
            ],
        ];

        $columns['nullable:true'] = [
            'string' => [
            ],
            'date'   => [
                'signing_date',
            ],
            'text'   => [
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
