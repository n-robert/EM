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
        dd($path);
        $path = parent::to($path, $extra, $secure);

        // We'll explicitly assign secure scheme
        if (!app()->environment('local') || $secure) {
            return to_https($path);
        }

        return $path;
    }
}
