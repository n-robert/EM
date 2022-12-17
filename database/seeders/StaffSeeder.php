<?php

namespace Database\Seeders;

use App\Models\EmployeeJob;
use App\Models\Employer;
use App\Models\Staff;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Employee;

class StaffSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
//        Staff::truncate();

        DB::table('employees')
          ->select(['employees.id as employee_id', 'employees.status_id as status_id', 'employee_job.employer_id as employer_id'])
          ->leftJoin('employee_job', 'employee_job.employee_id', '=', 'employees.id')
          ->whereIn('employees.status_id', [1, 2, 12])
          ->whereNotEmpty('employee_job.employee_id')
          ->orderBy('employees.id')
          ->groupBy(['employees.id', 'employee_job.employer_id'])
          ->chunk(100, function ($data) {
              $tmpEmployees = [];

              foreach ($data as $datum) {
                  if (!isset($tmpEmployees[$datum->employer_id])) {
                      $tmpEmployees[$datum->employer_id] = [];
                  }

                  $tmpEmployees[$datum->employer_id][] = $datum->employee_id;
              }

//              dd($tmpEmployees);
              foreach ($tmpEmployees as $employerId => $newEmployees) {
                  $year = Carbon::now()->isoFormat('YYYY');
                  $month = Carbon::now()->isoFormat('MM');
                  $staffModel =
                      Staff::withoutGlobalScopes()
                           ->where([
                               'year'        => $year,
                               'month'       => $month,
                               'employer_id' => $employerId,
                           ])
                           ->first() ?? new Staff();

                  $employees = $staffModel->employees ?? [];
                  $employees = array_unique(
                      array_merge($employees, $newEmployees)
                  );
                  $staffModel
                      ->fill([
                          'year'      => $year,
                          'month'     => $month,
                          'employees' => $employees,
                          'employer_id' => $employerId,
                          'user_ids'  => Employer::withoutGlobalScopes()->find($employerId)->user_ids,
                      ])
                      ->save();
              }
          });
    }
}
