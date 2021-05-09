<?php

namespace App\Models;

use App\Http\Requests\AddressFormRequest;
use Illuminate\Support\Facades\DB;

class Address extends BaseModel
{
    /**
     * Repeatable fields.
     *
     * @var array
     */
    public $repeatable = ['usage_permits' => ['id' => null, 'name_ru' => null, 'employer_id' => null, 'signing_date' => null]];

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
        if (!$result = parent::save($options)) {
            return $result;
        }

        $attributes = app(AddressFormRequest::class)->except('type');

        if (empty($attributes['usage_permits'])) {
            $this->usagePermits()->delete();

            return $result;
        }

        $coming = $attributes['usage_permits'];
        $existing = $this->usagePermits->all();
        $actual = [];
        $abandoned = [];

        foreach ($coming as &$new) {
            $new['address_id'] = $this->id;
            $new['user_ids'] = session($this->name . '.user_ids');
            $actual[] = $new['id'];
        }

        foreach ($existing as &$old) {
            if (!in_array($old->id, $actual)) {
                $abandoned[] = $old->id;
            }
        }

        if (!empty($abandoned)) {
            $this->usagePermits()->whereIn('id', $abandoned)->delete();
        }

        $this->usagePermits()->upsert($coming, ['id'], ['name_ru', 'employer_id', 'signing_date']);

        return $result;
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
