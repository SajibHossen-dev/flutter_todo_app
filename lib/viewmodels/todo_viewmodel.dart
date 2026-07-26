import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:flutter_todo_app/repositories/todo_repositories.dart';
import 'package:flutter_todo_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoViewmodel extends ChangeNotifier {
  final TodoRepositories repositories;
  TodoViewmodel(this.repositories);

  List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // error message handle

  String _getErrorMessage(Object e) {
    if (e is DioException) {
      final data = e.response?.data;

      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }

      // connection timeout
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return 'Request timeout. Please try again.';
      }
      // server not connection

      if (e.type == DioExceptionType.connectionError) {
        return 'Unable to connect to server';
      }

      return 'Something went wrong. Please try again';
    }
    return 'something went wrong';
  }

  // get todos
  Future<void> loadTodos() async {
    _isLoading = true;
    _errorMessage = 'Todo title cannot be empty';
    notifyListeners();
    try {
      _errorMessage = null;
      final data = await repositories.getTodos();
      _todos = data;
    } catch (e) {
      _errorMessage = _getErrorMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // create todo

  Future<bool> addTodo(String title) async {
    if (title.trim().isEmpty) {
      return false;
    }

    try {
      final todo = await repositories.createTodo(title.trim());

      _todos.add(todo);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTodo(int index) async {
    try {
      _errorMessage = null;
      final todo = _todos[index];
      final success = await repositories.deleteTodo(todo.id);
      if (success) {
        _todos.removeAt(index);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> toggleComplete(int index) async {
    try {
      final oldTodo = _todos[index];
      final updateTodo = await repositories.updateCompleted(
        oldTodo.id,
        !oldTodo.isCompleted,
      );
      _todos[index] = updateTodo;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> editTodo(int index, String newTitle) async {
    if (newTitle.trim().isEmpty) {
      _errorMessage = 'Todo title cannot be empty';
      notifyListeners();
      return false;
    }
    try {
      _errorMessage = null;
      final oldTodo = _todos[index];

      final updateTodo = await repositories.editTodo(
        oldTodo.id,
        newTitle.trim(),
      );

      _todos[index] = updateTodo;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

  // Future<void> saveTodos() async {
  //   final presf = await SharedPreferences.getInstance();
  //   final jsonList = _todos.map((e) => e.toJson()).toList();

  //   await presf.setString("todos", jsonEncode(jsonList));
  // }
}
