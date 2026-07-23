import 'package:flutter_todo_app/services/api_service.dart';

class AuthRepository {
  final ApiService apiService;
  AuthRepository(this.apiService);

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
}
