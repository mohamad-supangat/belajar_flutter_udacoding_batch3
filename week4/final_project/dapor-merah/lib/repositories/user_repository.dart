import 'package:dio/dio.dart';

import 'package:DaporMerah/helpers/helpers.dart';
import 'package:DaporMerah/models/User.dart';

class UserRepository {
  static Future<User> getUserAuth() async {
    try {
      final Response response = await callApi().get('/user/auth');
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('error geting user auth data');
    }
  }
}
