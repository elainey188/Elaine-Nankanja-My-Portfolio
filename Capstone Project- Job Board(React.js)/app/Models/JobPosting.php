<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JobPosting extends Model
{
    use HasFactory;

    protected $fillable = [
        'job_title',
        'job_description',
        'salary',
        'location',
        'company_name',
        'industry',
        'job_type',
    ];

    public function employer()
    {
        return $this->belongsTo(Employer::class);
    }
}
