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
        $types = DB::table('types')->pluck('id', 'code');
        $employerIds = DB::table('employers')
                         ->whereNotIn('type_id', [$types['UFMS'], $types['OUFMS'], $types['CLIENT']])
                         ->pluck('id');
        $statuses = DB::table('statuses')->pluck('id', 'name_en');
        $bossStatus = $statuses['Boss'];
        $hiredStatus = $statuses['Hired'];
        $firedStatus = $statuses['Fired'];
        Staff::truncate();

        DB::table('employee_turnover')
          ->select(['employee_id', 'employer_id', 'date', 'status_id'])
          ->whereIn('status_id', [$hiredStatus, $firedStatus])
          ->orderBy('date')
          ->chunk(400, function ($data) use ($hiredStatus, $firedStatus, $employerIds) {
              $hired = [];
              $fired = [];

              foreach ($data as $datum) {
                  $tmpYear = Carbon::parse($datum->date)->isoFormat('YYYY');
                  $tmpMonth = Carbon::parse($datum->date)->isoFormat('MM');
                  $tmpEmployerId = $datum->employer_id;

                  if (!isset($hired[$tmpYear])) {
                      $hired[$tmpYear] = [];
                  }

                  if (!isset($fired[$tmpYear])) {
                      $fired[$tmpYear] = [];
                  }

                  if (!isset($hired[$tmpYear][$tmpMonth])) {
                      $hired[$tmpYear][$tmpMonth] = [];
                  }

                  if (!isset($fired[$tmpYear][$tmpMonth])) {
                      $fired[$tmpYear][$tmpMonth] = [];
                  }

                  if (!isset($hired[$tmpYear][$tmpMonth][$tmpEmployerId])) {
                      $hired[$tmpYear][$tmpMonth][$tmpEmployerId] = [];
                  }

                  if (!isset($fired[$tmpYear][$tmpMonth][$tmpEmployerId])) {
                      $fired[$tmpYear][$tmpMonth][$tmpEmployerId] = [];
                  }

                  if ($datum->status_id == $hiredStatus) {
                      $hired[$tmpYear][$tmpMonth][$tmpEmployerId][] = $datum->employee_id;
                  } else {
                      $fired[$tmpYear][$tmpMonth][$tmpEmployerId][] = $datum->employee_id;
                  }
              }

              ksort($hired);
              ksort($fired);

              foreach ($hired as $year => $hiredThisYear) {
                  $firedThisYear = $fired[$year] ?? [];

                  for ($month = 1; $month < 13; $month++) {
                      if ($month == 1) {
                          $lastYear = (string)($year - 1);
                          $firedLastYear = $fired[$lastYear] ?? [];
                          $firedLastMonth = $firedLastYear['12'] ?? [];
                          $lastMonthStaffYear = $lastYear;
                          $lastMonthStaffMonth = '12';
                      } else {
                          $lastMonth = $month < 11
                              ? '0' . ($month - 1)
                              : (string)($month - 1);
                          $firedLastMonth = $firedThisYear[$lastMonth] ?? [];
                          $lastMonthStaffYear = $year;
                          $lastMonthStaffMonth = $lastMonth;
                      }

                      $month = $month < 10
                          ? '0' . $month
                          : (string)$month;
                      $hiredThisMonth = $hiredThisYear[$month] ?? [];

                      foreach ($employerIds as $employerId) {
                          $newEmployees = $hiredThisMonth[$employerId] ?? [];
                          $firedLastMonth[$employerId] = $firedLastMonth[$employerId] ?? [];
                          $lastMonthStaffModel =
                              Staff::withoutGlobalScopes()
                                   ->where([
                                       'year'        => $lastMonthStaffYear,
                                       'month'       => $lastMonthStaffMonth,
                                       'employer_id' => $employerId,
                                   ])
                                   ->first();
                          $lastMonthStaff = $lastMonthStaffModel->employees ?? [];
                          $employees = array_merge(
                          // Remove employees fired last month, who are still in last month's staff
                              array_diff(
                                  $lastMonthStaff,
                                  $firedLastMonth[$employerId]
                              ),
                              $newEmployees
                          );
                          $staffModel =
                              Staff::withoutGlobalScopes()
                                   ->where([
                                       'year'        => $year,
                                       'month'       => $month,
                                       'employer_id' => $employerId,
                                   ])
                                   ->first() ?? new Staff();

                          if ($employees) {
                              $staffModel
                                  ->fill([
                                      'year'        => $year,
                                      'month'       => $month,
                                      'employees'   => $employees,
                                      'employer_id' => $employerId,
                                      'user_ids'    => Employer::withoutGlobalScopes()->find($employerId)->user_ids,
                                  ])
                                  ->save();
                          }
                      }
                  }
              }
          });

        DB::table('employees')
          ->select(['employees.id as employee_id', 'employees.status_id as status_id', 'employee_job.employer_id as employer_id'])
          ->leftJoin('employee_job', 'employee_job.employee_id', '=', 'employees.id')
          ->whereIn('employees.status_id', [1, 11])
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
