<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CoverLetter extends Model
{
    use HasFactory;

    protected $primaryKey = 'PK_CoverLetter_ID';

    protected $fillable = [
        'name',
    ];

    public function applications()
    {
        return $this->hasMany(Application::class, 'CoverLetter_ID');
    }
}