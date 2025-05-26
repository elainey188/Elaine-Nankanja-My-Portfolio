<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->increments('PK_UserID');
            $table->string('Name');
            $table->integer('FK_AccountID')->unsigned();
            $table->foreign('FK_AccountID')->references('PK_AccountID')->on('accounts');
            $table->string('Email');
            $table->string('Phone_number');
            $table->string('Address');
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
        Schema::dropIfExists('users');
    }
}
