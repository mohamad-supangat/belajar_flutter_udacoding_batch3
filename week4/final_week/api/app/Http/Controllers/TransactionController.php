<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Transaction;
use Illuminate\Http\Request;

class TransactionController extends Controller
{
  public function action(Request $request)
  {
    $request->validate([
      'title'          => 'required',
      'description'   => '',
      'type'          => 'required',
      'amount'        => 'required',
    ]);

    $transaction = Transaction::updateOrCreate([
      'id'              => $request->id,
    ], [
      'title'           => $request->title,
      'description'     => $request->description,
      'type'            => $request->type,
      'amount'          => $request->amount,
      'user_id'         => auth()->id(),
    ]);

    foreach ($request->categories as $category) {
      $categories[] = Category::updateOrCreate([
        'name'    => $category,
      ])->id;
    }
    $transaction->categories()->sync($categories);

    return response()->json([
      'status'        => $transaction ? true : false,
      'transaction'   => $transaction,
    ]);
  }

  public function lists(Request $request)
  {
    $transactions = Transaction::orderBy('id', 'DESC')->with('categories');
    return response()->json([
      'status'        => true,
      'transactions'  => $transactions->simplePaginate(10)
    ]);
  }
}
