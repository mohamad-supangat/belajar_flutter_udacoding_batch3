<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Category;

class CategoryController extends Controller
{
  /**
   * Mengambil list semua data kategori
   *
   * @return laravel response json
   */
  public function list()
  {
    $categories = Category::orderBy('name', 'ASC')->get();

    return response()->json([
      'status'        => true,
      'categories'     => $categories
    ]);
  }
}
