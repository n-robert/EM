<?php

namespace App\Models;


class Type extends BaseModel
{
    /**
     * @var string
     */
    static $defaultName = 'name';

    /**
     * @var array
     */
    protected $defaultOrderBy = ['name'];
}
