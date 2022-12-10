<?php

namespace App\Http\Requests;

use Illuminate\Validation\Rule;

class EmployerRequestValidation extends BaseRequestValidation
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        return [
            'type_id'      => [
                'required',
            ],
            'name_ru'      => [
                'required',
            ],
            'full_name_ru' => [
                'required',
            ],
            'director_id'  => [
                'required',
            ],
            //            'booker_id' => [
            //                'required',
            //            ],
            //            'taxpayer_id' => [
            //                'required',
            //                Rule::unique('employers')->ignore($this->employer),
            //            ],
        ];
    }
}
