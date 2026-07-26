import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:flutter_todo_app/viewmodels/todo_viewmodel.dart';
import 'package:provider/provider.dart';

class TodoTitle extends StatelessWidget {
  final TodoModel todo;
  final int index;
  const TodoTitle({super.key, required this.todo, required this.index});

  void _showEditDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController(
      text: todo.title,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Task"),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cancle"),
            ),
            ElevatedButton(
              onPressed: () async {
                final newTodo = controller.text.trim();
                if (newTodo.isEmpty) {
                  return;
                }
                 final viewModel = context.read<TodoViewmodel>();
                final success = await context.read<TodoViewmodel>().editTodo(
                  index,
                  newTodo,
                );
               
                if (!context.mounted) return;

                Navigator.pop(context);

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Todo Update Successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        viewModel.errorMessage ?? "Failed to update todo",
                      ),
                    ),
                  );
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) async {
             final viewModel = context.read<TodoViewmodel>();
            final success = await context.read<TodoViewmodel>().toggleComplete(
              index,
            );

            if (!success && context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(viewModel.errorMessage??"Failed to update todo")));
            }
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

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                 final viewModel = context.read<TodoViewmodel>();
                final success = await context.read<TodoViewmodel>().deleteTodo(
                  index,
                );
                if (!success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(viewModel.errorMessage ?? "Failed to delete todo")),
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _showEditDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
