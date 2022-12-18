<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call([
//            StatusSeeder::class,
        ]);

        $this->call([
//            CountrySeeder::class,
//            AddressSeeder::class,
//            UsagePermitSeeder::class,
//            TypeSeeder::class,
//            EmployerSeeder::class,
//            QuotaSeeder::class,
            PermitSeeder::class,
//            OccupationSeeder::class,
        ]);

        $this->call([
            EmployeeSeeder::class,
//            StaffSeeder::class,
        ]);

        $tables = [
            'countries',
            'addresses',
            'employees',
            'employee_job',
            'employee_turnover',
            'employers',
            'staff',
            'occupations',
            'usage_permits',
            'permits',
            'quotas',
            'statuses',
            'types',
        ];

        foreach ($tables as $table) {
            DB::update(DB::raw("SELECT setval('" . $table . "_id_seq', (SELECT MAX(id) FROM " . $table . ")+1)"));
        }
    }
}
