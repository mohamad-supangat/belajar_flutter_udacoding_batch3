<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Kamus;

class KamusController extends Controller
{
  /**
   * get kamus data
   *
   * @return void
   */
  public function get(Request $request)
  {
    $kamus  = Kamus::orderBy('id', 'DESC');
    if ($search =  $request->search) {
      $kamus->where('title', 'like', "%{$search}%")
        ->orWhere('description', 'like', "%{$search}%");
    }
    return $kamus->paginate(10);
  }
}
