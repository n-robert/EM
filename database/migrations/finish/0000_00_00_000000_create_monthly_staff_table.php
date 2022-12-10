<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMonthlyStaffTable extends Migration
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
            ],
        ];

        $columns['default:["*"]'] = [
            'jsonb' => [
                'user_ids',
            ],
        ];

        Schema::create('monthly_staff', function (Blueprint $table) use ($columns) {
            $table->id();
            add_columns_from_array($columns, $table);
            $table->index(['year', 'month', 'employer_id']);
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
        Schema::dropIfExists('monthly_staff');
    }
}
