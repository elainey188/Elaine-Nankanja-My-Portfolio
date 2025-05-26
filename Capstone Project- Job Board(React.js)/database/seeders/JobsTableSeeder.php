<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class JobsTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('jobs')->insert([
            [
                'PK_JobID' => 89471,
                'FK_POSTING_ID' => 11111,
                'FK_LocationID' => 19991,
                'FK_CategoryID' => 91231,
                'FK_EmployerID' => 9001,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_JobID' => 89472,
                'FK_POSTING_ID' => 11112,
                'FK_LocationID' => 19992,
                'FK_CategoryID' => 91232,
                'FK_EmployerID' => 9002,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_JobID' => 89473,
                'FK_POSTING_ID' => 11113,
                'FK_LocationID' => 19993,
                'FK_CategoryID' => 91233,
                'FK_EmployerID' => 9003,
                'created_at' => now(),
                'updated_at' => now(),
            ]

        ]);
    }
}
