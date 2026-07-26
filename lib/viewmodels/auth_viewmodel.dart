import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewmodel extends ChangeNotifier {
  final AuthRepository repository;
  AuthViewmodel(this.repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  String? _successMessage;
  String? get successMessage => _successMessage;

  // handle api error

  String _getErrorMessage(Object e) {
    if (e is DioException) {
      final data = e.response?.data;

      // backend error message
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
      // timeout
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return 'Request timeout. Please try again.';
      }
      // server connection error
      if (e.type == DioExceptionType.connectionError) {
        return 'Unable to connect to server';
      }
      return 'Something went wrong. Please try again';
    }
    return 'Something went wrong';
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
    try {
      final data = await repository.register(
        name: name,
        email: email,
        password: password,
      );
      // backend success message
      _successMessage =
          data['message']?.toString() ?? 'Registration successful';
      return true;
    } catch (e) {
      _errorMessage = _getErrorMessage(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
    try {
      final data = await repository.login(email: email, password: password);
      final token = data['token'];

      if (token == null || token.toString().isEmpty) {
        _errorMessage = 'token not found';
        return false;
      }

      // save token

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      // get backend success message
      _successMessage = data['message']?.toString() ?? 'login successful';
      print('login Token :$token');
      return true;
    } catch (e) {
      _errorMessage = _getErrorMessage(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
