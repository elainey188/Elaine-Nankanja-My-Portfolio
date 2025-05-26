<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateJobsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('jobs', function (Blueprint $table) {
            $table->increments('PK_JobID');
            $table->integer('FK_POSTING_ID')->unsigned();
            $table->foreign('FK_POSTING_ID')->references('PK_PostingID')->on('job_postings');
            $table->integer('FK_LocationID')->unsigned();
            $table->foreign('FK_LocationID')->references('PK_LocationID')->on('location');
            $table->integer('FK_CategoryID')->unsigned();
            $table->foreign('FK_CategoryID')->references('PK_CategoryID')->on('categories');
            $table->integer('FK_EmployerID')->unsigned();
            $table->foreign('FK_EmployerID')->references('PK_EmployerID')->on('employers');
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
        Schema::dropIfExists('jobs');
    }
}
