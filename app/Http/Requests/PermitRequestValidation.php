<?php

namespace App\Http\Requests;

class PermitRequestValidation extends BaseRequestValidation
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        return [
            'number' => 'required',
        ];
    }
}
