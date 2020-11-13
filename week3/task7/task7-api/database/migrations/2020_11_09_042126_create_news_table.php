<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateNewsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('news', function (Blueprint $table) {
          $table->id();
          $table->string('title')->comment('Judul berita');
          $table->string('image')->comment('Url Gambar / foto');
          $table->longText('body')->comment('Isi Berita');
          $table->string('user')->comment('Nama user yang membuat berita');
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
        Schema::dropIfExists('news');
    }
}
