import 'package:dio/dio.dart';
import 'package:flutter_todo_app/services/api_service.dart';

class AuthRepository {
  final ApiService apiService;
  AuthRepository(this.apiService);
  // register function
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await apiService.post(
      'user/register',
      data: {'name': name, 'email': email, 'password': password},
    );
  }

  // login function

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      'user/login',
      data: {'email': email, 'password': password},
    );
    return response.data['token'];
  }
}
