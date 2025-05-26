<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CompanyInfoSeeder extends Seeder
{
    public function run()
    {
        DB::table('company_info')->insert([
            [
                'PK_CompanyID' => 81755411,
                'FK_EmployerID' => 9001,
                'Company Information' => 'We are a software development company based in California.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_CompanyID' => 81755412,
                'FK_EmployerID' => 9002,
                'Company Information' => 'We are a marketing agency that specializes in digital marketing strategies.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'PK_CompanyID' => 81755413,
                'FK_EmployerID' => 9003,
                'Company Information' => 'We are a financial services company that offers investment and insurance solutions.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
