import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_model.dart';

class TodoTitle extends StatelessWidget {
  final TodoModel todo;
  const TodoTitle({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(title: Text(todo.title)));
  }
}
