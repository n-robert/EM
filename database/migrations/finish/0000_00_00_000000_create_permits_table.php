<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePermitsTable extends Migration
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
            'unsignedBigInteger' => [
                'employer_id',
                'quota_id',
            ],
            'jsonb' => [
                'user_ids',    // previous type - int_array
            ],
        ];

        $columns['unique'] = [
            'string' => [
                '64' => [
                    'number',
                ],
            ],
        ];

        $columns['nullable:true'] = [
            'integer' => [
                'total',
            ],

            'date' => [
                'issued_date',
                'expired_date',
            ],

            'jsonb' => [
                'history',
                'details',
            ],
        ];

        Schema::create('permits', function (Blueprint $table) use ($columns) {
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
        Schema::dropIfExists('permits');
    }
}
