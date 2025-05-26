<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Job extends Model
{
    use HasFactory;

    protected $fillable = [
        'fk_posting_id',
        'fk_location_id',
        'fk_category_id',
        'fk_employer_id',
    ];

    public function posting()
    {
        return $this->belongsTo(JobPosting::class, 'fk_posting_id');
    }

    public function location()
    {
        return $this->belongsTo(Location::class, 'fk_location_id');
    }

    public function category()
    {
        return $this->belongsTo(Category::class, 'fk_category_id');
    }

    public function employer()
    {
        return $this->belongsTo(Employer::class, 'fk_employer_id');
    }

    public function applications()
    {
        return $this->hasMany(Application::class, 'fk_job_id');
    }
}
