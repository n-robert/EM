<?php

namespace App\Services;

use App\Models\Status;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Mail;

class ReminderService
{
    /**
     * @param bool $cli
     * @return string|null
     */
    public static function visaExtensionReminder(bool $cli = true): ?string
    {
        $statuses = Status::query()->pluck('id', 'name_en')->all();
        $currentUser = Auth::user();
        $userEmails = !$cli ? [$currentUser->id => $currentUser->email]
            : User::query()->whereNotIn('email', ['ngphnam@gmail.com'])->pluck('email', 'id')->all();
        $now = Carbon::now();
        $term = $now->addWeekdays(60);
        $result = [];

        array_walk($userEmails, function ($email, $id) use ($statuses, $term, &$result) {
            $user = User::find($id);
            $query = DB::table('employees')
                       ->where('visa_expired_date', '<=', $term)
                       ->where('status_id', $statuses['Hired'])
                       ->orderBy('visa_expired_date');
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

            if ($data) $result[$email] = $data;
        });
//        dd($result);
        if (!$result) return null;

        try {
            $text = [];
            array_walk($result, function ($data, $email) use ($cli, &$text) {
                $text = [__('Visas of following employees expire soon:')];
                array_walk($data, function ($items, $date) use (&$text) {
                    $text[] = "   $date:";

                    foreach ($items as $k => $item) {
                        $k++;
                        $text[] = "      $k. $item";
                    }
                });
                $text = implode(PHP_EOL, $text);

                if ($cli && Gate::allows('can-edit')) {
                    Mail::raw($text, function (Message $message) use ($email) {
                        $message->to($email);
                    });
                }
            });
        } catch (\Exception $e) {
            echo $e->getMessage();
        }
//        dd($text);
        return $text;
    }
}
