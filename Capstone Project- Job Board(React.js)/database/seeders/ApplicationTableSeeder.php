<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ApplicationTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('applications')->insert([
            [
                'PK_ApplicationID'=> 2345671,
                'FK_ContactID' => 1001,
                'FK_ResumeID' => 6761,
                'CoverLetter_ID' =>21910,
                'FK_UserID' => 1010,
                'FK_JobID' => 89471,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_ApplicationID'=> 2345672,
                'FK_ContactID' => 1002,
                'FK_ResumeID' =>  6762,
                'CoverLetter_ID' => 21911,
                'FK_UserID' => 1012,
                'FK_JobID' => 89472,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_ApplicationID'=> 2345673,
                'FK_ContactID' => 1003,
                'FK_ResumeID' => 6763,
                'CoverLetter_ID' => 21912,
                'FK_UserID' => 1013,
                'FK_JobID' => 89473,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
