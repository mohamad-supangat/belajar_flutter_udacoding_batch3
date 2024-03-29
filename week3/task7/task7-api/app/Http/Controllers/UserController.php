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
    if (!$token = auth()->attempt($credentials)) {
      return response()->json([
        'status'  => false,
        'message' => 'Username / password yang anda masukan salah',
      ]);
    }

    return response()->json([
      'status' => true,
      'token'  => $token,
      'user'   => auth()->user()
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

  /**
   * Logout
   *
   * @return void
   */
  public function logout()
  {
    auth()->logout(true);
    return response()->json([
      'status'    => true,
      'message'   => 'Sukses menghapus sesi login'

    ]);
  }


  /**
   * undocumented function
   *
   * @return void
   */
  public function update_profile(Request $request)
  {
    $request->validate([
      'username'    => 'required|min:5|max:20|unique:users,username,'.\Auth::id(),
      'name'        => 'required|min:5|max:50',
      'email'       => 'required|min:5|max:50|unique:users,email,'.\Auth::id().'|email:filter',
      'password'    => 'nullable|min:5|max:20',
    ]);

    $new_data = [
      'username'    => $request->username,
      'name'        => $request->name,
      'email'       => $request->email,
    ];
    if ($new_password = $request->password) {
      $new_data['password'] = bcrypt($request->password);
    }

    $proses = \Auth::user()->update($new_data);
    return response()->json([
      'status'      => $proses ? true : false,
      'message'     => $proses ? 'Sukes mengupdate profile' : 'Gagal melakukan perubahan',
    ]);
  }
} 
