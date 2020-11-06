import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
  baseUrl: "https://127.0.0.1/api",
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio $dio = new Dio(options);
