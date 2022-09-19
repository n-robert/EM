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
     * @param  \Illuminate\Routing\RouteCollectionInterface  $routes
     * @param  \Illuminate\Http\Request  $request
     * @param  string|null  $assetRoot
     * @return void
     */
    public function __construct(RouteCollectionInterface $routes, Request $request, $assetRoot = null)
    {
        parent::__construct($routes, $request, $assetRoot);

        if (!app()->environment('local')) {
            $this->forceScheme('https');
        }
    }
}
