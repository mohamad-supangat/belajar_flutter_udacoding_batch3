<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\News as ModelsNews;

class NewsController extends Controller
{
  /**
   * get news data
   *
   * @return Paginate news jso
   */
  public function get()
  {
    $news  = ModelsNews::orderBy('id', 'DESC')->paginate(10);
    $news->getCollection()->transform(function ($new, $key) {
      $new['create_date'] = $new->created_at->toDateString();
      return $new;
    });
    return $news;
  }
}
