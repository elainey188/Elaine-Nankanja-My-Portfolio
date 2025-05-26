<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AccountsTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('accounts')->insert([
            [
                'PK_AccountID' => 12345678,
                'username' => 'user1',
                'password' => bcrypt('password1'),
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_AccountID' => 23456789,
                'username' => 'user2',
                'password' => bcrypt('password2'),
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_AccountID' => 34567890,
                'username' => 'user3',
                'password' => bcrypt('password3'),
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
