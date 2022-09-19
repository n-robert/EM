<?php

namespace App\Http\Routing;

use Illuminate\Routing\Redirector;

class EMRedirector extends Redirector
{
    /**
     * Create a new redirect response to the given path.
     *
     * @param  string  $path
     * @param  int  $status
     * @param  array  $headers
     * @param  bool|null  $secure
     * @return \Illuminate\Http\RedirectResponse
     */
    public function to($path, $status = 302, $headers = [], $secure = null)
    {
        $path = preg_replace('~^(https://|http://|//)(.+)~', 'https://$2', $path);

        return $this->createRedirect($this->generator->to($path, [], $secure), $status, $headers);
    }
}
