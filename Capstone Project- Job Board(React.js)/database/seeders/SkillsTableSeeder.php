<?php
namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;


class SkillsTableSeeder extends Seeder
{
    
    public function run()
    {

    DB::table('skills')->insert([
        [
            'PK_SkillID' => 5651,
            'Name' => 'JavaScript',
            'Description' => 'Proficient in JavaScript programming language for building interactive web applications',
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_SkillID' => 5652,
            'Name' => 'Project Management',
            'Description' => 'Skilled in managing projects from conception to completion, with experience in leading cross-functional teams',
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_SkillID' => 5653,
            'Name' => 'Data Analysis',
            'Description' => 'Expert in analyzing large data sets to identify trends, patterns, and insights',
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_SkillID' => 5654,
            'Name' => 'Communication',
            'Description' => 'Excellent verbal and written communication skills, with the ability to articulate complex ideas to both technical and non-technical audiences',
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_SkillID' => 5655,
            'Name' => 'Graphic Design',
            'Description' => 'Proficient in using design software such as Adobe Photoshop and Illustrator to create visual designs for web and print media',
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_SkillID' => 5656,
            'Name' => 'Leadership',
            'Description' => 'Ability to inspire and motivate team members towards a common goal, while providing guidance and direction as needed',
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_SkillID' => 5657,
            'Name' => 'Time Management',
            'Description' => 'Efficient in managing time and prioritizing tasks to meet project deadlines',
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_SkillID' => 5658,
            'Name' => 'Problem Solving',
            'Description' => 'Adept in identifying and solving complex problems by breaking them down into smaller, manageable parts',
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_SkillID' => 5659,
            'Name' => 'Teamwork',
            'Description' => 'Collaborative team player with the ability to work effectively in diverse team environments',
            'created_at' => now(),
            'updated_at' => now(),
        ],
    ]);
}
}
