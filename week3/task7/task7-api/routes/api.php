<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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
  Route::post('login', '\App\Http\Controllers\UserController@login');
  Route::post('register', '\App\Http\Controllers\UserController@register');

  Route::middleware('auth:api')->get('auth', function (Request $request) {
    return $request->user();
  });
  Route::get('logout', '\App\Http\Controllers\UserController@logout')
    ->middleware('auth:api');
});

Route::get('/news', '\App\Http\Controllers\NewsController@get');
Route::get('/kamus', '\App\Http\Controllers\KamusController@get');
