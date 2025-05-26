<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Location extends Model
{
    use HasFactory;

    protected $primaryKey = 'location_id';

    protected $fillable = ['country', 'state', 'city'];

    public function jobs()
    {
        return $this->hasMany(Job::class);
    }
}
