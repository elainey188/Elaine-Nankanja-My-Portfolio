<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PostingsTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('job_postings')->insert([
            [
                'PK_PostingID' => 11111,
                'Job Title' => 'Software Developer',
                'Job Description' => 'We are looking for a skilled software developer to join our team and work on exciting new projects.',
                'Salary' => '70,000 - 90,000 USD',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_PostingID' => 11112,
                'Job Title' => 'Marketing Manager',
                'Job Description' => 'We are seeking an experienced marketing manager to lead our team and develop successful marketing strategies.',
                'Salary' => '80,000 - 100,000 USD',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_PostingID' => 11113,
                'Job Title' => 'Financial Analyst',
                'Job Description' => 'We are looking for a detail-oriented financial analyst to join our team and help us make informed financial decisions.',
                'Salary' => '60,000 - 80,000 USD',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
