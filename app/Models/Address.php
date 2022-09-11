<?php

namespace App\Models;

use App\Http\Requests\AddressRequestValidation;
use Illuminate\Support\Facades\DB;

class Address extends BaseModel
{
    /**
     * @var array
     */
    public $listable = ['id', 'name_ru'];

    /**
     * Repeatable fields.
     *
     * @var array
     */
    public $repeatable = [
        'usage_permits' => [
            'id'           => null,
            'name_ru'      => null,
            'employer_id'  => null,
            'signing_date' => null
        ]
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = ['usage_permits'];

    /**
     * Get the model's usage permits.
     *
     * @return \Illuminate\Support\Collection
     */
    public function getUsagePermitsAttribute()
    {
        return
            DB::table('usage_permits')
              ->where('address_id', '=', $this->id)
              ->get(['id', 'name_ru', 'employer_id', 'signing_date']);
    }

    /**
     * Get all employers that has usage permits to address.
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function employers()
    {
        return $this->belongsToMany(Employer::class, 'usage_permits');
    }

    /**
     * Save the model to the database.
     *
     * @param  array $options
     * @return bool
     */
    public function save(array $options = [])
    {
        parent::save($options);

        $attributes = app(AddressRequestValidation::class)->except('type');
        $existing = $this->usagePermits->all();

        if (empty($attributes['usage_permits']) && !empty($existing)) {
            array_map(
                function ($usagePermit) {
                    UsagePermit
                        ::find($usagePermit->id)
                        ->delete();
                },
                $existing
            );

            return true;
        }

        $coming = $attributes['usage_permits'];
        $new = [];
        $abandoned = [];

        array_map(
            function ($actual) use (&$new) {
                $usagePermitsModel =
                    $actual['id'] ?
                        UsagePermit::find($actual['id']) : new UsagePermit();

                $usagePermitsModel->setAttribute('address_id', $this->id);
                $usagePermitsModel->setAttribute('user_ids', session($this->name . '.user_ids'));

                $usagePermitsModel
                    ->fill($actual)
                    ->save();

                $new[] = $actual['id'];
            },
            $coming
        );

        if (!empty($existing)) {
            array_map(
                function ($old) use ($new, &$abandoned) {
                    if (!in_array($old->id, $new)) {
                        $abandoned[] = $old->id;
                    }
                },
                $existing
            );
        }

        if (!empty($abandoned)) {
            array_map(
                function ($id) {
                    UsagePermit
                        ::find($id)
                        ->delete();
                },
                $abandoned
            );
        }

        return true;
    }

    /**
     * Get all usage permits of address.
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function usagePermits()
    {
        return $this->hasMany(UsagePermit::class);
    }
}
