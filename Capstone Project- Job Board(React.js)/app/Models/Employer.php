<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Employer extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'address',
        'username',
        'password',
        'fk_contact_id',
        'fk_user_id',
    ];

    public function contact()
    {
        return $this->belongsTo(Contact::class, 'fk_contact_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'fk_user_id');
    }

    public function companyInfo()
    {
        return $this->hasOne(CompanyInfo::class, 'fk_employer_id');
    }

    public function jobs()
    {
        return $this->hasMany(Job::class, 'fk_employer_id');
    }
}
