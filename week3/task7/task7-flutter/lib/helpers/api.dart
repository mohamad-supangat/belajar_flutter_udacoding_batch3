import 'package:dio/dio.dart';
import 'toast.dart';

BaseOptions options = new BaseOptions(
  baseUrl: "http://10.0.2.2:8000/api",
  connectTimeout: 5000,
  receiveTimeout: 3000,
  headers: {
    'Accept': 'application/json',
  },
);

Dio _dio = new Dio(options);
Dio callApi() {
  _dio.interceptors.add(LogInterceptor(responseBody: true));
  _dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        return options; //continue
      },
      onResponse: (Response response) async {
        // Do something with response data
        return response; // continue
      },
      onError: (DioError e) async {
        print(e);
        // Do something with response error
        return e; //continue
      },
    ),
  );

  return _dio;
}
