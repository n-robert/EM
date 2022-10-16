<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

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
            StatusSeeder::class,
        ]);

        $this->call([
            CountrySeeder::class,
            AddressSeeder::class,
            UsagePermitSeeder::class,
            TypeSeeder::class,
            EmployerSeeder::class,
            QuotaSeeder::class,
            PermitSeeder::class,
            OccupationSeeder::class,
        ]);

        $this->call([
            EmployeeSeeder::class,
        ]);
    }
}
