import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'http://localhost:4000/api',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'content-Type': 'application/json'},
        ),
      );
  Future<Response> get(String endpoint) async {
    return await dio.get(endpoint);
  }
}
