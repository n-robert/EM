<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEmployeeTurnoverTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('employee_turnover', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('employee_id');
            $table->unsignedBigInteger('employer_id')->nullable(true);
            $table->date('date')->nullable(true);
            $table->unsignedBigInteger('status_id');
            $table->addColumn('jsonb', 'user_ids');
            $table->timestamps();
            $table->unique(['employee_id', 'employer_id', 'date', 'status_id']);
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
        Schema::dropIfExists('employee_turnover');
    }
}
