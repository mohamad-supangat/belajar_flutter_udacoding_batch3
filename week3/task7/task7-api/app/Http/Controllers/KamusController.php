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
    $news  = Kamus::orderBy('id', 'DESC')->paginate(10);
    return $news;
  }
}
