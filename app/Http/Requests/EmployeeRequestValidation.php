<?php

namespace App\Http\Requests;

use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class EmployeeRequestValidation extends BaseRequestValidation
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        $statuses = DB::table('statuses')->pluck('id', 'name_en');

        return [
            'status_id'                 => [
                'required',
            ],
            'last_name_ru'              => [
                'required',
            ],
            'first_name_ru'             => [
                'required',
            ],
            'citizenship_id'            => [
                'required',
            ],
            'passport_number'           => [
                'required',
                Rule::unique('employees')->ignore($this->employee),
            ],
            'entry_date' => [
                Rule::requiredIf(function () use ($statuses) {
                    return $this->request->get('status_id') == $statuses['Arrived'];
                }),
            ],
            'departure_date' => [
                Rule::requiredIf(function () use ($statuses) {
                    return $this->request->get('status_id') == $statuses['Left'];
                }),
            ],
            'employee_job.*.contract_number' => [
                Rule::requiredIf(function () use ($statuses) {
                    return $this->request->get('status_id') == $statuses['Hired'];
                }),
            ],
            'employee_job.*.hired_date' => [
                Rule::requiredIf(function () use ($statuses) {
                    return $this->request->get('status_id') == $statuses['Hired'];
                }),
            ],
            'employee_job.*.fired_date' => [
                Rule::requiredIf(function () use ($statuses) {
                    return $this->request->get('status_id') == $statuses['Fired'];
                }),
            ],
        ];
    }
}
