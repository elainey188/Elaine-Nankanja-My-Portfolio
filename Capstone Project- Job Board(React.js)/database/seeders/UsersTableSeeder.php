<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UsersTableSeeder extends Seeder
{
    public function run()
{
    DB::table('users')->insert([
        [
            'PK_UserID' => '1010',
            'Name' => 'John Doe',
            'Email' => 'john@example.com',
            'Phone_number' => '123-456-7890',
            'Address' => '123 Main St',
            'FK_AccountID' => 1,
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_UserID' => '1012',
            'Name' => 'Jane Smith',
            'Email' => 'jane@example.com',
            'Phone_number' => '555-555-5555',
            'Address' => '456 Elm St',
            'FK_AccountID' => 2,
            'created_at' => now(),
            'updated_at' => now(),
        ],
        [
            'PK_UserID' => '1013',
            'Name' => 'Bob Johnson',
            'Email' => 'bob@example.com',
            'Phone_number' => '999-999-9999',
            'Address' => '789 Oak St',
            'FK_AccountID' => 3,
            'created_at' => now(),
            'updated_at' => now(),
        ]
    ]);
}

    
};
