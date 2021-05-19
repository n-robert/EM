<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\User;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $columns = [
            'id',
            'name',
            'email',
            'email_verified_at',
            'password',
            'remember_token',
            'current_team_id',
            'profile_photo_path',
            'is_admin',
            'created_at',
            'updated_at',
        ];

        $oldData = DB::connection('mysql')->table('users')->get();
        User::truncate();

        foreach ($oldData as $oldDatum) {
            $newData = [];

            foreach ($columns as $column) {
                $value = $oldDatum->$column;
                $newData[$column] = $value;
            }

            User::insert($newData);
        }
    }
}
