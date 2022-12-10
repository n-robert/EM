<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEmployeeJobTable extends Migration
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
                'employee_id',
                'employer_id',
            ],
            'jsonb'              => [
                'user_ids',
            ],
        ];

        $columns['nullable:true'] = [
            'string'             => [
                '32' => [
                    'contract_number',
                ],
            ],
            'date'               => [
                'hired_date',
                'fired_date',
            ],
            'unsignedBigInteger' => [
                'occupation_id',
                'work_address_id',
            ],
            'jsonb' => [
                'history',
            ],
        ];

        Schema::create('employee_job', function (Blueprint $table) use ($columns) {
            $table->id();
            add_columns_from_array($columns, $table);
            $table->timestamps();
            $table->foreign('employee_id')
                  ->references('id')
                  ->on('employees')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('employee_job');
    }
}
