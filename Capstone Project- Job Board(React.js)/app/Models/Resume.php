<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Resume extends Model
{
    use HasFactory;

    protected $primaryKey = 'PK_ResumeID';

    protected $fillable = [
        'name',
        'education',
        'experience',
        'FK_SkillID',
    ];

    public function skill()
    {
        return $this->belongsTo(Skill::class, 'FK_SkillID');
    }

    public function applications()
    {
        return $this->hasMany(Application::class, 'FK_ResumeID');
    }
}