import 'package:dio/dio.dart';
import 'toast.dart';
import 'dart:developer';

Dio callApi() {
  BaseOptions options = new BaseOptions(
    baseUrl: "http://10.0.2.2:8000/api",
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {
      'Accept': 'application/json',
    },
  );

  Dio _dio = new Dio(options);

  _dio.interceptors.add(LogInterceptor(responseBody: true));
  _dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        return options; //continue
      },
      onResponse: (Response response) async {
        return response; // continue
      },
      onError: (DioError e) async {
        // tangkap kode 422 eror / laravel validation
        if (e.response.statusCode == 422) {
          for (List errors in e.response.data['errors'].values) {
            showToast(type: 'error', message: errors.first.toString());
            break;
          }
        } else {
          showToast(type: 'error', message: 'Terjadi kesalahan pada jaringan');
        }
        return e; //continue
      },
    ),
  );

  return _dio;
}
