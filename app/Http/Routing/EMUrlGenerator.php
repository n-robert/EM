<?php

namespace App\Http\Routing;

use Illuminate\Routing\UrlGenerator;

class EMUrlGenerator extends UrlGenerator
{
    /**
     * Generate an absolute URL to the given path.
     *
     * @param  string  $path
     * @param  mixed  $extra
     * @param  bool|null  $secure
     * @return string
     */
    public function to($path, $extra = [], $secure = null)
    {
        // We'll explicitly assign secure scheme
        if (!app()->environment('local') || $secure) {
            $path = to_https($path);
        }

        return parent::to($path, $extra, $secure);
    }
}
