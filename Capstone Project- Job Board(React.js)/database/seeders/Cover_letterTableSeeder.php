<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class Cover_letterTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('cover_letters')->insert([
            [
                'PK_CoverLetter_ID' => 21910,
                'Name' => 'Generic Cover Letter',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_CoverLetter_ID' => 21911,
                'Name' => 'Software Developer Cover Letter',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_CoverLetter_ID' => 21912,
                'Name' => 'Marketing Manager Cover Letter',
                'created_at' => now(),
                'updated_at' => now(),
            ]
    
        ]);
    }
}
