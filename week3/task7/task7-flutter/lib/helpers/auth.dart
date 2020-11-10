import 'package:shared_preferences/shared_preferences.dart';
import 'package:task7/models/User.dart';
import 'dart:convert';
import 'api.dart';

class Auth {
  Future<User> user() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return User.fromJson(jsonDecode(localStorage.getString('user')));
  }

  getUser() async {}

  Future<String> token() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString('token');
  }

  Future<bool> logout() async {
    await callApi().get('/user/logout');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    return true;
  }
}
