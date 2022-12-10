<?php

namespace Database\Seeders;

use App\Models\EmployeeJob;
use App\Models\MonthlyStaff;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Employee;

class MonthlyStaffSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $employeeJobColumns = [
            'employer_id',
            'contract_number',
            'occupation_id',
            'work_address_id',
            'hired_date',
            'fired_date',
        ];

        MonthlyStaff::truncate();

        DB::table('employees')
          ->select(['employees.id as employee_id', 'employee_job.employer_id as employer_id'])
          ->leftJoin('employee_job', 'employee_job.employee_id', '=', 'employees.id')
          ->whereIn('employees.status_id', [1, 2, 12])
          ->whereNotEmpty('employee_job.employee_id')
          ->orderBy('employees.id')
          ->groupBy(['employees.id', 'employee_job.employer_id'])
          ->chunk(100, function ($data) {
              $rows = [];

              foreach ($data as $datum) {
                  if (!isset($rows[$datum->employer_id])) {
                      $rows[$datum->employer_id] = [
                          'year' => Carbon::now()->isoFormat('YYYY'),
                          'month' => Carbon::now()->isoFormat('MM'),
                          'employer_id' => $datum->employer_id,
                          'employees' => []
                      ];
                  }

                  $rows[$datum->employer_id]['employees'][] = $datum->employee_id;
              }

             foreach ($rows as $row) {
                 $test = $row;
                 unset($test['employees']);
                 unset($test['employees']);
                 if ($monthStaff = MonthlyStaff::find($test)->all()) {
                     $employees = array_merge(json_decode($monthStaff->employees), $row['employees']);
                     $monthStaff->setAttribute('employees', json_encode($employees))->save();
                 } else {
                     // Save new monthly_staff table's row
                     $row['employees'] = json_encode($row['employees']);
                     MonthlyStaff::withoutGlobalScopes()->insert($row);
                 }
             }
          });
    }
}
