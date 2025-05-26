<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class ContactSeeder extends Seeder
{
    public function run()
    {
        DB::table('contacts')->insert([
            [
                'PK_ContactID' => 1001,
                'Email' => 'lolab5@deity.ca',
                'Phone Number' => '123-456-7890',
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'PK_ContactID' => 1002,
                'Email' => 'mikeshiraza@abcpharmacy.ca',
                'Phone Number' => '555-555-5555',
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'PK_ContactID' => 1003,
                'Email' => 'tracyv78@gmail.com',
                'Phone Number' => '555-123-4567',
                'created_at' => now(),
                'updated_at' => now()
            ]
        ]);
    }
    
}
