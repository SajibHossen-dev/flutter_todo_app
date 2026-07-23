import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:flutter_todo_app/repositories/todo_repositories.dart';
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

  // get todos
  Future<void> loadTodos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _todos = await repositories.getTodos();
    } catch (e) {
      _errorMessage = e.toString();
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
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> deleteTodo(int index) async {
    _todos.removeAt(index);
    await saveTodos();
    notifyListeners();
  }

  Future<void> toggleComplete(int index) async {
    _todos[index].isCompleted = !_todos[index].isCompleted;
    await saveTodos();
    notifyListeners();
  }

  Future<void> editTodo(int index, String newTitle) async {
    if (newTitle.trim().isEmpty) return;
    _todos[index].title = newTitle.trim();
    await saveTodos();
    notifyListeners();
  }

  Future<void> saveTodos() async {
    final presf = await SharedPreferences.getInstance();
    final jsonList = _todos.map((e) => e.toJson()).toList();

    await presf.setString("todos", jsonEncode(jsonList));
  }
}
