<?php

namespace App\Http\Routing;

use Illuminate\Http\RedirectResponse;
use Illuminate\Routing\Redirector;
use Illuminate\Routing\UrlGenerator;

class EMRedirector extends Redirector
{
    /**
     * Create a new Redirector instance.
     *
     * @param UrlGenerator $generator
     * @return void
     */
    public function __construct(UrlGenerator $generator)
    {
        parent::__construct($generator);
    }

    /**
     * Create a new redirect response to the given path.
     *
     * @param  string  $path
     * @param  int  $status
     * @param  array  $headers
     * @param  bool|null  $secure
     * @return RedirectResponse
     */
    public function to($path, $status = 302, $headers = [], $secure = null)
    {
        $path = preg_replace('~^(https://|http://|//)(.+)~', 'https://$2', $path);

        return $this->createRedirect($this->generator->to($path, [], $secure), $status, $headers);
    }
}
