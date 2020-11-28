<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCategoryTransactionTable extends Migration
{
  /**
   * Run the migrations.
   *
   * @return void
   */
  public function up()
  {
    Schema::create('category_transaction', function (Blueprint $table) {
      /* $table->id(); */
      $table->integer('transaction_id');
      $table->integer('category_id');
      /* $table->timestamps(); */
    });
  }

  /**
   * Reverse the migrations.
   *
   * @return void
   */
  public function down()
  {
    Schema::dropIfExists('category_transaction');
  }
}
