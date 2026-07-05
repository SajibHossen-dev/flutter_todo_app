import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoViewmodel extends ChangeNotifier {
  final List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;
  TodoViewmodel() {
    loadTodos();
  }

  Future<void> addTodo(String title) async {
    if (title.trim().isEmpty) return;
    _todos.add(TodoModel(title: title, isCompleted: false));
    await saveTodos();
    notifyListeners();
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

  void editTodo(int index, String newTitle) {
    if (newTitle.trim().isEmpty) return;
    _todos[index].title = newTitle;
    notifyListeners();
  }

  Future<void> saveTodos() async {
    final presf = await SharedPreferences.getInstance();
    final jsonList = _todos.map((e) => e.toJson()).toList();

    presf.setString("todos", jsonEncode(jsonList));
  }

  Future<void> loadTodos() async {
    final presf = await SharedPreferences.getInstance();
    final data = presf.getString("todos");
    if (data == null) return;
    final List decoded = jsonDecode(data);
    _todos.clear();
    _todos.addAll(decoded.map((e) => TodoModel.fromJson(e)));
    notifyListeners();
  }
}
