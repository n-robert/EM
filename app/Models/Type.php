<?php

namespace App\Models;


class Type extends BaseModel
{
    /**
     * @var string
     */
    public static $defaultName = 'code';

    /**
     * @var bool
     */
    public static $skipAuthUserScope = true;

    /**
     * @var array
     */
    protected $defaultOrderBy = ['code'];
}
