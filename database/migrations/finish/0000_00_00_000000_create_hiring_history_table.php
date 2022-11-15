<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEmployeeHiringHistoryTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('hiring_history', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('employee_id', null);
            $table->date('entry_date', null)->nullable(true);
            $table->date('hired_date', null)->nullable(true);
            $table->date('fired_date', null)->nullable(true);
            $table->date('departure_date', null)->nullable(true);
            $table->addColumn('int_array', 'user_ids');
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
        Schema::dropIfExists('hiring_history');
    }
}
