import 'package:dio/dio.dart';

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = "https://jsonplaceholder.typicode.com";
  }

  Dio get dio => _dio;
}
