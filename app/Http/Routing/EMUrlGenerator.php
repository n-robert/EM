<?php

namespace App\Http\Routing;

use Illuminate\Contracts\Routing\UrlGenerator as UrlGeneratorContract;
use Illuminate\Http\Request;
use Illuminate\Routing\RouteCollectionInterface;
use Illuminate\Routing\UrlGenerator;

class EMUrlGenerator extends UrlGenerator implements UrlGeneratorContract
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
     * Get the current URL for the request.
     *
     * @return string
     */
    public function current() {
        return parent::current();
    }

    /**
     * Get the URL for the previous request.
     *
     * @param  mixed  $fallback
     * @return string
     */
    public function previous($fallback = false) {
        return parent::previous($fallback);
    }

    /**
     * Generate an absolute URL to the given path.
     *
     * @param  string  $path
     * @param  mixed  $extra
     * @param  bool|null  $secure
     * @return string
     */

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

    /**
     * Generate a secure, absolute URL to the given path.
     *
     * @param  string  $path
     * @param  array  $parameters
     * @return string
     */
    public function secure($path, $parameters = []) {
        return parent::secure($path, $parameters);
    }

    /**
     * Generate the URL to an application asset.
     *
     * @param  string  $path
     * @param  bool|null  $secure
     * @return string
     */
    public function asset($path, $secure = null) {
        return parent::asset($path, $secure);
    }

    /**
     * Get the URL to a named route.
     *
     * @param  string  $name
     * @param  mixed  $parameters
     * @param  bool  $absolute
     * @return string
     *
     * @throws \InvalidArgumentException
     */
    public function route($name, $parameters = [], $absolute = true) {
        return parent::route($name, $parameters, $absolute);
    }

    /**
     * Get the URL to a controller action.
     *
     * @param  string|array  $action
     * @param  mixed  $parameters
     * @param  bool  $absolute
     * @return string
     */
    public function action($action, $parameters = [], $absolute = true) {
        return parent::action($action, $parameters, $absolute);
    }

    /**
     * Set the root controller namespace.
     *
     * @param  string  $rootNamespace
     * @return $this
     */
    public function setRootControllerNamespace($rootNamespace) {
        return parent::setRootControllerNamespace($rootNamespace);
    }
}
