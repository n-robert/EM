<?php

namespace App\Models;


class Type extends BaseModel
{
    /**
     * @var string
     */
    static $defaultName = 'code';

    /**
     * @var array
     */
    protected $defaultOrderBy = ['code'];
}
