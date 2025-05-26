<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEmployersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('employers', function (Blueprint $table) {
            $table->increments('PK_EmployerID');
            $table->string('Name');
            $table->string('Address');
            $table->string('Username');
            $table->string('Password');
            $table->integer('FK_ContactID')->unsigned();
            $table->foreign('FK_ContactID')->references('PK_ContactID')->on('contacts');
            $table->integer('FK_UserID')->unsigned();
            $table->foreign('FK_UserID')->references('PK_UserID')->on('users');
            $table->timestamps();
        });
    }
    

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('employers');
    }
}
