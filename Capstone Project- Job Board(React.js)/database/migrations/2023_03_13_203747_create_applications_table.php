<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateApplicationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('applications', function (Blueprint $table) {
            $table->increments('PK_ApplicationID');
            $table->integer('FK_ContactID')->unsigned();
            $table->foreign('FK_ContactID')->references('PK_ContactID')->on('contacts');
            $table->integer('FK_ResumeID')->unsigned();
            $table->foreign('FK_ResumeID')->references('PK_ResumeID')->on('resumes');
            $table->integer('CoverLetter_ID')->unsigned();
            $table->foreign('CoverLetter_ID')->references('PK_CoverLetter_ID')->on('cover_letters');
            $table->integer('FK_UserID')->unsigned();
            $table->foreign('FK_UserID')->references('PK_UserID')->on('users');
            $table->integer('FK_JobID')->unsigned();
            $table->foreign('FK_JobID')->references('PK_JobID')->on('jobs');
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
        Schema::dropIfExists('applications');
    }
}
