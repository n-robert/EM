<?php

namespace App\Models;

use App\Http\Requests\AddressRequestValidation;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class Address extends BaseModel
{
    /**
     * @var array
     */
    public $toSelect = ['id', 'name_ru'];

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
     * @return Collection
     */
    public function getUsagePermitsAttribute(): Collection
    {
        return
            DB::table('usage_permits')
              ->where('address_id', '=', $this->id)
              ->get(['id', 'name_ru', 'employer_id', 'signing_date'])
              ->mapWithKeys(function ($item) {
                  return [$item->employer_id => $item];
              });
    }

    /**
     * Get all employers that has usage permits to address.
     *
     * @return BelongsToMany
     */
    public function employers(): BelongsToMany
    {
        return $this->belongsToMany(Employer::class, 'usage_permits');
    }

    /**
     * Get all usage permits of address.
     *
     * @return HasMany
     */
    public function usagePermits(): HasMany
    {
        return $this->hasMany(UsagePermit::class);
    }

    /**
     * Save the model to the database.
     *
     * @param array $options
     * @return bool
     */
    public function save(array $options = []): bool
    {
        if (parent::save($options)) {
            $request = request()->except('type');
            $existing = $this->usagePermits->all();

            if (empty($request['usage_permits'])) {
                if (!empty($existing)) {
                    array_map(function ($usagePermit) {
                        UsagePermit::find($usagePermit->id)->delete();
                    }, $existing);
                }

                return true;
            }

            $new = [];
            $abandoned = [];

            if ($coming = $request['usage_permits']) {
                array_map(function ($actual) use (&$new) {
                    $usagePermitsModel = $actual['id'] ? UsagePermit::find($actual['id']) : new UsagePermit();
                    $usagePermitsModel->setAttribute('address_id', $this->id);
                    $usagePermitsModel->setAttribute('user_ids', session($this->name . '.user_ids'));
                    $usagePermitsModel->fill($actual)->save();
                    $new[] = $actual['id'];
                }, $coming);
            }

            if (!empty($existing)) {
                array_map(function ($old) use ($new, &$abandoned) {
                    if (!in_array($old->id, $new)) {
                        $abandoned[] = $old->id;
                    }
                }, $existing);
            }

            if (!empty($abandoned)) {
                array_map(function ($id) {
                    UsagePermit::find($id)->delete();
                }, $abandoned);
            }

            return true;
        }

        return false;
    }
}
