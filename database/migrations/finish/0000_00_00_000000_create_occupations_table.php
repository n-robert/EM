<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOccupationsTable extends Migration
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
            'jsonb' => [
                'user_ids',    // previous type - int_array
            ],
        ];

        $columns['unique'] = [
            'string' => [
                '32' => [
                    'code',
                ],
                '128' => [
                    'name_ru',
                ],
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

        Schema::create('occupations', function (Blueprint $table) use ($columns) {
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
        Schema::dropIfExists('occupations');
    }
}
