<?php

namespace App\Models;

class UsagePermit extends BaseModel
{
    /**
     * Get the address that owns the certificate.
     */
    public function address()
    {
        return $this->belongsTo(Address::class)->withoutGlobalScopes();
    }

    /**
     * Get the employer that owns the certificate.
     */
    public function employer()
    {
        return $this->belongsTo(Employer::class)->withoutGlobalScopes();
    }
}
