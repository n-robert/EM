<?php

namespace App\Http\Routing;

use Illuminate\Http\Request;
use Illuminate\Routing\RouteCollectionInterface;
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
        // First we will get rid of scheme
        $path = preg_replace('~^(https://|http://|//)(.+)~', '$2', $path);

        return parent::to($path, $extra, $secure);
    }
}
