<?php

namespace Database\Seeders;

use App\Models\EmployeeJob;
use App\Models\Employer;
use App\Models\Staff;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\DB;
use App\Models\Employee;
use Illuminate\Support\Facades\Mail;

class StaffSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @param bool $monthly
     * @return void
     */
    public function run(bool $monthly = false)
    {
        $types = DB::table('types')->pluck('id', 'code');
        $employerIds = DB::table('employers')
                         ->whereNotIn('type_id', [$types['UFMS'], $types['OUFMS'], $types['CLIENT']])
                         ->pluck('id');
        $statuses = DB::table('statuses')->pluck('id', 'name_en');
        $bossStatus = $statuses['Boss'];
        $hiredStatus = $statuses['Hired'];
        $firedStatus = $statuses['Fired'];
        $thisYear = Carbon::now()->isoFormat('YYYY');
        $thisMonth = Carbon::now()->isoFormat('MM');
        $hired = [];
        $fired = [];
        $query = DB::table('employee_turnover')
                   ->select(['employee_id', 'employer_id', 'date', 'status_id'])
                   ->whereIn('status_id', [$bossStatus, $hiredStatus, $firedStatus])
                   ->orderBy('date');

        if ($monthly) {
            if ($thisMonth == '01') {
                $query->whereYear('date', (string)((int)$thisYear - 1))
                      ->whereMonth('date', '12');
            } else {
                $query->whereYear('date', $thisYear)
                      ->whereMonth('date', (string)((int)$thisMonth - 1));
            }
        } else {
            Staff::truncate();
        }

        $query->chunk(
            100,
            function ($data) use ($bossStatus, $hiredStatus, $firedStatus, $employerIds, &$hired, &$fired) {
                foreach ($data as $datum) {
                    $tmpYear = Carbon::parse($datum->date)->isoFormat('YYYY');
                    $tmpMonth = Carbon::parse($datum->date)->isoFormat('MM');
                    $tmpEmployerId = $datum->employer_id;
                    $hired[$tmpYear][$tmpMonth][$tmpEmployerId] = $hired[$tmpYear][$tmpMonth][$tmpEmployerId] ?? [];
                    $fired[$tmpYear][$tmpMonth][$tmpEmployerId] = $fired[$tmpYear][$tmpMonth][$tmpEmployerId] ?? [];

                    if ($datum->status_id == $firedStatus) {
                        $fired[$tmpYear][$tmpMonth][$tmpEmployerId][] = $datum->employee_id;
                    } else {
                        $hired[$tmpYear][$tmpMonth][$tmpEmployerId][] = $datum->employee_id;
                    }
                }

            }
        );
        $hired[$thisYear] = $hired[$thisYear] ?? [];
        $fired[$thisYear] = $fired[$thisYear] ?? [];

        ksort($hired);
        ksort($fired);

        foreach ($hired as $year => $hiredThisYear) {
            $firedThisYear = $fired[$year] ?? [];
            $startMonth = 1;
            $finishMonth = ($year == $thisYear) ? (int)$thisMonth : 12;

            if ($monthly) {
                if ($thisMonth != '01') {
                    $startMonth = (int)$thisMonth - 1;
                    $finishMonth = (int)$thisMonth;
                } else {
                    if ($year == $thisYear) {
                        $startMonth = $finishMonth = 1;
                    } else {
                        $startMonth = $finishMonth = 12;
                    }
                }
            }

            for ($month = $startMonth; $month < $finishMonth + 1; $month++) {
                if ($month == 1) {
                    $lastYear = (string)((int)$year - 1);
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
                    $hiredThisMonth[$employerId] = $hiredThisMonth[$employerId] ?? [];
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
                        $hiredThisMonth[$employerId]
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

        if ($monthly) {
            try {
                Mail::raw('Updated staff (' . $thisYear . '-' . $thisMonth . ').', function (Message $message) {
                    $message->to('7715377@mail.ru');
                });
            } catch (\Exception $e) {
                echo $e->getMessage();
            }
        }
    }
}
