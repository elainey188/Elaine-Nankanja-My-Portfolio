<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CompanyInfo extends Model
{
    use HasFactory;

    protected $fillable = [
        'fk_employer_id',
        'company_information',
    ];

    public function employer()
    {
        return $this->belongsTo(Employer::class, 'fk_employer_id');
    }
}
