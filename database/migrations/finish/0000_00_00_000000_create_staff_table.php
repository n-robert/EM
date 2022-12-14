<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateStaffTable extends Migration
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
            'string'             => [
                '32' => [
                    'year',
                    'month',
                ],
            ],
            'unsignedBigInteger' => [
                'employer_id',
            ],
            'jsonb'              => [
                'employees',
                'user_ids',
            ],
        ];

        Schema::create('staff', function (Blueprint $table) use ($columns) {
            $table->id();
            add_columns_from_array($columns, $table);
            $table->timestamps();
            $table->unique(['year', 'month', 'employer_id']);
            $table->foreign('employer_id')
                  ->references('id')
                  ->on('employers')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('staff');
    }
}
