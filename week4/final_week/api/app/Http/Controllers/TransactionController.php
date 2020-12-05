<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

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
        'name'    => ucwords(strtolower($category)),
      ])->id;
    }
    $transaction->categories()->sync($categories);

    return response()->json([
      'status'        => $transaction ? true : false,
      'transaction'   => $transaction,
    ]);
  }

  public function lists()
  {
    $transactions = Transaction::orderBy('id', 'DESC')
      ->filterUser();

    $transactions = $transactions->simplePaginate(10);
    $transactions->getCollection()->transform(function ($transaction) {
      return [
        'title'         => $transaction->title,
        'description'   => $transaction->description,
        'type'          => $transaction->type,
        'amount'        => $transaction->amount,
        'categories'    => $transaction->categories->pluck('name'),
        'created_at'    => $transaction->created_at,
        'updated_at'    => $transaction->updated_at,
      ];
    });
    return response()->json([
      'status'        => true,
      'transactions'  => $transactions
    ]);
  }


  public function statistic()
  {
    $transactionModel = function () {
      return Transaction::filterUser()->orderBy('id', 'desc');
    };

    $total = [
      'in'      => $transactionModel()->where('type', 'in')->get()->sum('amount'),
      'out'     => $transactionModel()->where('type', 'out')->get()->sum('amount'),
    ];


    $transactionChartModel = function () use ($transactionModel) {
      return $transactionModel()
        ->select([DB::Raw('sum(amount) as amount'), DB::Raw('DATE(created_at) as date')])
        ->groupBy('date');
    };

    $chart_data = [
      'in'        => $transactionChartModel()->where('type', 'in')->get(),
      'out'       => $transactionChartModel()->where('type', 'out')->get(),
    ];

    return response()->json([
      'total' => $total,
      'chart' => $chart_data,
    ]);
  }
}
