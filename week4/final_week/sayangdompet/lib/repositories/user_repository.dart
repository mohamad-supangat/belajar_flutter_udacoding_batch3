import 'package:dio/dio.dart';

import 'package:sayangdompet/helpers/helpers.dart';
import 'package:sayangdompet/models/User.dart';

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
