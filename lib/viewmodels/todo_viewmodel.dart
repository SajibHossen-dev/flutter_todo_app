import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_model.dart';

class TodoViewmodel extends ChangeNotifier {
  final List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  void addTodo(String title) {
     if (title.trim().isEmpty) return;
    _todos.add(
      TodoModel(title: title , isCompleted: false),
      
    );
    notifyListeners();
  }
}
