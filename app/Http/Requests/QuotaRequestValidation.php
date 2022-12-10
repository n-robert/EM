<?php

namespace App\Http\Requests;

class QuotaRequestValidation extends BaseRequestValidation
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        return [
            'year' => 'required',
        ];
    }
}
