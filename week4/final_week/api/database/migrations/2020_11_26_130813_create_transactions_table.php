<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTransactionsTable extends Migration
{
  /**
   * Run the migrations.
   *
   * @return void
   */
  public function up()
  {
    Schema::create('transactions', function (Blueprint $table) {
      $table->id();
      $table->string('title')->comment('Judul transaksi');
      $table->text('description')->comment('Deskripsi transaksi / keterangan tambahan');
      $table->enum('type', ['in', 'out'])->default('in')->comment('jenis transaksi masuk / keluar');
      $table->integer('amount')->comment('Jumlah nilai transaksi / uang ');
      $table->foreignId('user_id')->constrained('users');
      $table->softDeletes();
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
    Schema::dropIfExists('transactions');
  }
}
