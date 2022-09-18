<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Schema\Builder;

if (!function_exists('add_columns_from_array')) {
    function add_columns_from_array(array &$columns, Blueprint &$table)
    {
        foreach ($columns as $hasDefaultValue => $group) {
            foreach ($group as $type => $subGroup) {
                foreach ($subGroup as $length => $column) {
                    if (!is_array($column)) {
                        $column = [$column];
                        $length = null;
                    }

                    list($func, $arg) = array_pad(explode(':', $hasDefaultValue), 2, null);

                    array_walk(
                        $column,
                        function ($value) use ($table, $hasDefaultValue, $type, $length, $func, $arg) {
                            if ($type == 'int_array') {
                                $length = $length ?? Builder::$defaultStringLength;
                                ($hasDefaultValue == 'none') ?
                                    $table->addColumn($type, $value, compact('length')) :
                                    $table->addColumn($type, $value, compact('length'))->$func($arg);
                            } else {
                                ($hasDefaultValue == 'none') ?
                                    $table->$type($value, $length) : $table->$type($value, $length)->$func($arg);
                            }
                        }
                    );
                }
            }
        }
    }
}

if (!function_exists('get_translations')) {
    function get_translations()
    {
        $json = resource_path('lang/' . app()->getLocale() . '.json');

        if (!file_exists($json)) {
            return [];
        }

        return json_decode(file_get_contents($json), true);
    }
}

if (!function_exists('to_lower_case_array')) {
    function to_lower_case_array($str)
    {
        preg_match_all('/[A-Z]+(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+/', $str, $matches);

        return
            array_map(
                function ($value) {
                    return strtolower($value);
                },
                $matches[0]
            );
    }
}

if (!function_exists('to_phrase')) {
    function to_phrase($str)
    {
        return ucfirst(implode(' ', to_lower_case_array($str)));
    }
}

if (!function_exists('to_snake_case')) {
    function to_snake_case($str)
    {
        return implode('_', to_lower_case_array($str));
    }
}

if (!function_exists('to_kebab_case')) {
    function to_kebab_case($str)
    {
        return implode('-', to_lower_case_array($str));
    }
}

if (!function_exists('to_pascal_case')) {
    function to_pascal_case($str)
    {
        return
            implode(
                '',
                array_map(
                    function ($value) {
                        return ucfirst($value);
                    },
                    to_lower_case_array($str)
                )
            );
    }
}

if (!function_exists('to_camel_case')) {
    function to_camel_case($str)
    {
        $lowerCaseArray = to_lower_case_array($str);

        return
            implode(
                '',
                array_map(
                    function ($value, $key) {
                        return $key == 0 ? $value : ucfirst($value);
                    },
                    $lowerCaseArray,
                    array_keys($lowerCaseArray)
                )
            );
    }
}

if (!function_exists('to_upper_case')) {
    function to_upper_case($data)
    {
        if (is_array($data)) {
            return
                array_map(
                    function ($value) {
                        return mb_strtoupper($value);
                    },
                    $data
                );
        }

        return mb_strtoupper($data);
    }
}

if (!function_exists('validate_boolean')) {
    function validate_boolean($var, $bool_only = false)
    {
        if ($bool_only) {
            return filter_var($var, FILTER_VALIDATE_BOOLEAN);
        } else {
            $result = filter_var($var, FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) ?? $var;
            return $result;
        }
    }
}

if (!function_exists('secure_url')) {
    function secure_url($url)
    {
        return preg_replace('~^(https://|http://|//)(.+)$~', 'https://$2', $url);
    }
}
