<?php

namespace App\Http\Routing;

use Illuminate\Routing\UrlGenerator;

class EMUrlGenerator extends UrlGenerator
{
    public function to($path, $extra = [], $secure = null)
    {
        $path = parent::to($path, $extra, $secure);

        // We'll explicitly assign secure scheme
        if (!app()->environment('local') || $secure) {
            return preg_replace('~^(https://|http://|//)(.+)~', 'https://$2', $path);
        }

        return $path;
    }
}
