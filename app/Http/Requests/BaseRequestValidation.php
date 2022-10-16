<?php

namespace App\Http\Requests;

use Carbon\Carbon;
use Illuminate\Foundation\Http\FormRequest;

class BaseRequestValidation extends FormRequest
{

    /**
     * Get all of the input and files for the request.
     *
     * @param  array|mixed|null  $keys
     * @return array
     */
    public function all($keys = null)
    {
        return $this->sanitize(parent::all($keys));
    }

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
//        return !empty($this->user()->id);
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [];
    }

    /**
     * Sanitize all of the input and files for the request.
     *
     * @param  array  $input
     * @return array
     */
    public function sanitize($input)
    {
        array_walk_recursive($input, function (&$value, $key) {
            if (str_ends_with($key, '_date') && $value) {
                $value = Carbon::parse($value)->isoFormat('YYYY-MM-DD');
            }
        });

        return $input;
    }
}
