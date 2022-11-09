<?php

namespace App\Http\Routing;

use Illuminate\Routing\UrlGenerator;
use Illuminate\Support\Str;

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
        return parent::to($path, $extra, true);
    }
}
