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
        // First we will get rid of non-secure schema if we need HTTPS
        if ($secure) {
            $path = preg_replace('~^(http://|//)~', '', $path);
        }

        return parent::to($path, $extra, $secure);
    }
}
