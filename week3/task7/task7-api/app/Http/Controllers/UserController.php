<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

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

    $credentials = request(['username', 'password']);
    if (! $token = auth()->attempt($credentials)) {
      return response()->json([
        'status'  => false,
        'message' => 'Username / password yang anda masukan salah',
      ]);
    }

    return response()->json([
      'status' => true,
      'token'  => $token
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

    $proses = User::create([
      'username'  => $request->username,
      'name'      => $request->name,
      'email'     => $request->email,
      'password'  => bcrypt($request->password),
    ]);

    return response()->json([
      'status'      => $proses ? true : false,
      'message'     => $proses ? 'Sukes melakukan pendaftaran' : 'Gagal melakukan pendaftaran', 
    ]);
  }
  
} 
