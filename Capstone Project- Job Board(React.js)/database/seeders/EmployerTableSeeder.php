<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

use Illuminate\Support\Facades\DB;

class EmployerTableSeeder extends Seeder
{

    public function run()
    {
        DB::table('employers')->insert([
            [
                'PK_EmployerID' => '9001',
                'Name' => 'ABC Company',
                'Address' => '123 Main St',
                'Username' => 'abc_user',
                'Password' => bcrypt('abc_password'),
                'FK_ContactID' => 1001,
                'FK_UserID' => 1010,
            ],
            [
                'PK_EmployerID' => '9002',
                'Name' => 'XYZ Inc',
                'Address' => '456 Elm St',
                'Username' => 'xyz_user',
                'Password' => bcrypt('xyz_password'),
                'FK_ContactID' =>1002,
                'FK_UserID' => 1012,
            ],
            [
                'PK_EmployerID' => '9003',
                'Name' => 'MNO Corporation',
                'Address' => '789 Oak St',
                'Username' => 'mno_user',
                'Password' => bcrypt('mno_password'),
                'FK_ContactID' => 1003,
                'FK_UserID' => 1013,
            ]
            ]);

    }
}
