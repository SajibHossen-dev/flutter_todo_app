import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:flutter_todo_app/viewmodels/todo_viewmodel.dart';
import 'package:provider/provider.dart';

class TodoTitle extends StatelessWidget {
  final TodoModel todo;
  final int index;
  const TodoTitle({super.key, required this.todo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) {
            context.read<TodoViewmodel>().toggleComplete(index);
          },
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),

        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            context.read<TodoViewmodel>().deleteTodo(index);
          },
        ),
      ),
    );
  }
}
