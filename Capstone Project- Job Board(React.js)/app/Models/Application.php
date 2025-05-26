<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Application extends Model
{
    use HasFactory;

    protected $fillable = ['contact_id', 'resume_id', 'cover_letter_id', 'user_id', 'job_id'];

    public function contact()
    {
        return $this->belongsTo(Contact::class);
    }

    public function resume()
    {
        return $this->belongsTo(Resume::class);
    }

    public function coverLetter()
    {
        return $this->belongsTo(CoverLetter::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function job()
    {
        return $this->belongsTo(Job::class);
    }
}
