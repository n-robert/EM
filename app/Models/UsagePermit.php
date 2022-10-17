<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;

class UsagePermit extends BaseModel
{
    /**
     * Get the address that owns the certificate.
     */
    public function address(): BelongsTo
    {
        return $this->belongsTo(Address::class)->withoutGlobalScopes();
    }

    /**
     * Get the employer that owns the certificate.
     */
    public function employer(): BelongsTo
    {
        return $this->belongsTo(Employer::class)->withoutGlobalScopes();
    }
}
