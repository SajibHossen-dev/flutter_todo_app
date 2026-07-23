import 'package:flutter/material.dart';
import 'package:flutter_todo_app/repositories/auth_repository.dart';

class AuthViewmodel extends ChangeNotifier {
  final AuthRepository repository;
  AuthViewmodel(this.repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await repository.register(name: name, email: email, password: password);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
