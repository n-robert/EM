<?php

namespace App\Services;

use App\Models\Status;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;

class ReminderService
{
    public static function visaExtensionReminder()
    {
        $statuses = Status::query()->pluck('id', 'name_en')->all();
        $userEmails = User::query()->whereNotIn('email', ['ngphnam@gmail.com'])->pluck('email', 'id')->all();
        $now = Carbon::now();
        $term = $now->addWeekdays(60);
        $result = [];

        array_walk($userEmails, function ($email, $id) use ($statuses, $term, &$result) {
            $user = User::find($id);
            $query = DB::table('employees')
                       ->where('visa_expired_date', '<=', $term)
                       ->where('status_id', $statuses['Hired']);
            $query = !UserService::isAdmin($user) ? $query->whereJsonContains('user_ids', $id) : $query;
            $deadlineSoon = $query->get()->all();
            $data = [];

            array_map(function ($item) use (&$data) {
                $date = Carbon::parse($item->visa_expired_date)->isoFormat('DD-MM-YYYY');
                $data[$date][] = implode(
                    ' ',
                    array_filter([
                        $item->last_name_ru,
                        $item->first_name_ru,
                        $item->middle_name_ru
                    ])
                );
            }, $deadlineSoon);

            $result[$email] = $data;
        });
//        dd($result);
        try {
            if (!$result) return;

            array_walk($result, function ($data, $email) {
                $text = [];
                $text[] = __('Visas of following employees expire soon:');
                array_walk($data, function ($items, $date) use (&$text) {
                    $text[] = "   $date:";

                    foreach ($items as $k => $item) {
                        $k++;
                        $text[] = "      $k. $item";
                    }
                });
                $text = implode(PHP_EOL, $text);
//                dd($text);
                Mail::raw($text, function (Message $message) use ($email) {
                    $message->to($email);
                });
            });
        } catch (\Exception $e) {
            echo $e->getMessage();
        }
    }
}
