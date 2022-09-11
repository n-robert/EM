<?php

namespace App\Http\Requests;

class AddressRequestValidation extends BaseRequestValidation
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'name_ru' => 'required',
        ];
    }
}
