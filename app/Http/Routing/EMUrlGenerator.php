<?php

namespace App\Http\Routing;

use Illuminate\Http\Request;
use Illuminate\Routing\RouteCollectionInterface;
use Illuminate\Routing\UrlGenerator;

class EMUrlGenerator extends UrlGenerator
{
    /**
     * Create a new URL Generator instance.
     *
     * @param RouteCollectionInterface $routes
     * @param Request $request
     * @param  string|null  $assetRoot
     * @return void
     */
    public function __construct(RouteCollectionInterface $routes, Request $request, $assetRoot = null)
    {
        parent::__construct($routes, $request, $assetRoot);
    }

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
        $path = parent::to($path, $extra, $secure);

        // We'll explicitly assign secure scheme
        if (!app()->environment('local') || $secure) {
            return preg_replace('~^(https://|http://|//)(.+)~', 'https://$2', $path);
        }

        return $path;
    }
}
