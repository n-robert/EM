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
            $path = preg_replace('~^(https://|http://|//)~', '', $path);
        }

        $tail = implode('/', array_map(
                'rawurlencode', (array) $this->formatParameters($extra))
        );

        // Once we have the scheme we will compile the "tail" by collapsing the values
        // into a single string delimited by slashes. This just makes it convenient
        // for passing the array of parameters to this URL as a list of segments.
        $root = $this->formatRoot($this->formatScheme($secure));

        [$path, $query] = $this->extractQueryString($path);

        return $this->format(
                $root, '/'.trim($path.'/'.$tail, '/')
            ).$query;
    }
}
