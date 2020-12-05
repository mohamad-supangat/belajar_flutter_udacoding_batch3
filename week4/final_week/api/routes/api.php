<?php

use App\Http\Controllers\CategoryController;
use App\Http\Controllers\TransactionController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::prefix('/user')->group(function () {
  Route::post('login', [UserController::class, 'login']);
  Route::post('register', [UserController::class, 'register']);

  // api untuk mendapatkan detail user
  Route::middleware('auth:api')
    ->get('auth', function (Request $request) {
      return $request->user();
    });

  Route::middleware('auth:api')
    ->post('update_profile', [UserController::class, 'update_profile']);
  Route::middleware('auth:api')
    ->get('logout', [UserController::class, 'logout']);
});


Route::prefix('/category')->group(function () {
  Route::get('list', [CategoryController::class, 'list']);
});


Route::prefix('/transaction')->middleware('auth:api')->group(function () {
  Route::get('statistic', [TransactionController::class, 'statistic']);
  Route::post('action', [TransactionController::class, 'action']);
  Route::get('lists', [TransactionController::class, 'lists']);
});
