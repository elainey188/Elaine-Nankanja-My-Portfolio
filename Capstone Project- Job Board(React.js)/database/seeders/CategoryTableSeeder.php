<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

use Illuminate\Support\Facades\DB;

class CategoryTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('categories')->insert([
            [
                'PK_CategoryID' => 91231,
                'Name' => 'Technology',
                'Description' => 'IT and Software Related.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_CategoryID' => 91232,
                'Name' => 'Retail',
                'Description' => 'Dealing with products and services',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_CategoryID' => 91233,
                'Name' => 'Finance',
                'Description' => 'Managing money, investments, and risk',
                'created_at' => now(),
                'updated_at' => now(),


            ]
        ]);
        }
}
