<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

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

    $categories = [];
    foreach ($request->categories as $category) {
      $categories[] = Category::updateOrCreate([
        'name'    => ucwords(strtolower($category)),
      ])->id;
    }

    if (count($categories) > 0) {
      $transaction->categories()->sync($categories);
    }

    return response()->json([
      'status'        => $transaction ? true : false,
      'transaction'   => $transaction,
    ]);
  }

  public function lists()
  {
    $transactions = Transaction::filterUser()->orderBy('created_at', 'DESC');

    $transactions = $transactions->simplePaginate(10);
    $transactions->getCollection()->transform(function ($transaction) {
      return [
        'title'         => $transaction->title,
        'description'   => $transaction->description,
        'type'          => $transaction->type,
        'amount'        => $transaction->amount,
        'categories'    => $transaction->categories->pluck('name'),
        // 'created_at'    => $transaction->created_at,
        'created_at'    => Carbon::parse($transaction->created_at)->format('d M Y h:i'),
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
      return Transaction::filterUser();
    };

    $total = [
      'in'      => $transactionModel()->where('type', 'in')->get()->sum('amount'),
      'out'     => $transactionModel()->where('type', 'out')->get()->sum('amount'),
    ];


    $transactionChartModel = function () use ($transactionModel) {
      return $transactionModel()
        ->select([DB::Raw('sum(amount) as amount'), DB::Raw("DATE_FORMAT(created_at, '%y%m%d') as date")])
        ->groupBy('date')
        ->orderBy('date', 'ASC');
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
