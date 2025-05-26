<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ResumesTableSeeder extends Seeder
{
    public function run()
    {
        
        $skillIds = DB::table('skills')->take(7)->pluck('PK_SkillID')->toArray();

        $selectedSkillIds = array_rand(array_flip($skillIds), 7);
        $skillIdsString = implode(',', $selectedSkillIds);
        

    
            DB::table('resumes')->insert([
                [
                    'PK_ResumeID' => 6761,
                    'Name' => 'John Doe',
                    'Education' => 'Bachelor of Science in Computer Science',
                    'Experience' => '3 years of experience as a software developer',
                    'FK_SkillID' => $skillIds[array_rand($skillIds)],
                    'created_at' => now(),
                    'updated_at' => now(),
                ],
                [
                    'PK_ResumeID' => 6762,
                    'Name' => 'Jane Smith',
                    'Education' => 'Master of Business Administration',
                    'Experience' => '5 years of experience in project management',
                    'FK_SkillID' => $skillIds[array_rand($skillIds)],
                    'created_at' => now(),
                    'updated_at' => now(),
                ],
                [
                    'PK_ResumeID' => 6763,
                    'Name' => 'Bob Johnson',
                    'Education' => 'Bachelor of Arts in English',
                    'Experience' => '2 years of experience in content writing',
                    'FK_SkillID' => $skillIds[array_rand($skillIds)],
                    'created_at' => now(),
                    'updated_at' => now(),
                ],
            ]);
        }
    }

