<?php

namespace App\Contracts;


interface ControllerInterface
{
    /**
     * Handle dynamic method calls into the controller.
     *
     * @param  string $method
     * @param  array $parameters
     * @return mixed
     */
    public function __call($method, $parameters);
}