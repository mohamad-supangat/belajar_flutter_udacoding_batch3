<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class UserController extends Controller
{
  /**
   * Login 
   *
   * @return object response
   */
  public function login(Request $request)
  {
    $request->validate([
      'username'      => 'required|min:5|max:20',
      'password'      => 'required|min:5|max:20',
    ]);
  }
  
  /**
   * fungsi untuk pendaftaran akun user
   *
   * @return object response 
   */
  public function register(Request $request)
  {
    $request->validate([
      'username'    => 'required|min:5|max:20|unique:users,username',
      'name'        => 'required|min:5|max:50',
      'email'       => 'required|min:5|max:50|unique:users,email|email:filter',
      'password'    => 'required|min:5|max:20',
      'confirmation_password' => 'required|min:5|max:25|same:password'
    ]);

    $proses = User::create($request->all());

    return response()->json([
      'status'      => $proses ? true : false,
      'message'     => $proses ? 'Sukes melakukan pendaftaran' : 'Gagal melakukan pendaftaran', 
    ]);
  }
  
}
