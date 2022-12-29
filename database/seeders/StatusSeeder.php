<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Carbon\Carbon;
use App\Models\Status;
use Illuminate\Support\Facades\DB;

class StatusSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $statuses = [
            'Boss' => 'Руководитель',
            'Cancelled' => 'Аннулирован',
            'Client' => 'Контрагент',
            'Denied' => 'Отказан',
            'Family member' => 'Член семьи',
            'Fired' => 'Уволен',
            'On leave' => 'В отпуске',
            'Left' => 'Убыл',
            'Official' => 'Чиновник',
            'Seeker' => 'Соискатель',
            'Hired' => 'Сотрудник',
            'Arrived' => 'Прибыл',
        ];
        Status::truncate();

        foreach ($statuses as $name_en => $name_ru) {
            Status::withoutGlobalScopes()->insert([
                'name_en' => $name_en,
                'name_ru' => $name_ru,
                'user_ids' => json_encode(['*']),
            ]);
        }
    }
}
