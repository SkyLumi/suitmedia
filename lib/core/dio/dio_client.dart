import 'package:dio/dio.dart';

Dio createDio() {
  final dio = Dio();
  dio.options.headers['x-api-key'] = 'reqres-free-v1';
  return dio;
}
