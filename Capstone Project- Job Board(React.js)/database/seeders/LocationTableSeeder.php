<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class LocationTableSeeder extends Seeder
{
    public function run(){
    DB::table('location')->insert([
        [
            'PK_LocationID' => 19991,
            'Country' => 'USA',
            'State' => 'California',
            'City' => 'Los Angeles',
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_LocationID' => 19992,
            'Country' => 'USA',
            'State' => 'New York',
            'City' => 'New York City',
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_LocationID' => 19993,
            'Country' => 'Canada',
            'State' => 'Ontario',
            'City' => 'Toronto',
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_LocationID' => 19994,
            'Country' => 'Canada',
            'State' => 'Quebec',
            'City' => 'Montreal',
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_LocationID' => 19995,
            'Country' => 'Australia',
            'State' => 'New South Wales',
            'City' => 'Sydney',
            'created_at' => now(),
            'updated_at' => now(),
        ],
    ]);
    }
}
