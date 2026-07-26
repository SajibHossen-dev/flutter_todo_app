import 'package:flutter/material.dart';
import 'package:flutter_todo_app/services/api_service.dart';

class AuthRepository {
  final ApiService apiService;
  AuthRepository(this.apiService);

  // register function
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      'user/register',
      data: {'name': name, 'email': email, 'password': password},
    );
    return Map<String, dynamic>.from(response.data);
  }

  // login function

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      'user/login',
      data: {'email': email, 'password': password},
    );
    return Map<String, dynamic>.from(response.data);
  }
}
