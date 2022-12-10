<?php

namespace App\Http\Requests;

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
        return [
            'status_id' => [
                'required',
            ],
            'last_name_ru' => [
                'required',
            ],
            'first_name_ru' => [
                'required',
            ],
            'citizenship_id' => [
                'required',
            ],
            'passport_number' => [
                'required',
                Rule::unique('employees')->ignore($this->employee),
            ],
        ];
    }
}
