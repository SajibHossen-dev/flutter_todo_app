import 'package:flutter/material.dart';
import 'package:flutter_todo_app/viewmodels/todo_viewmodel.dart';
import 'package:flutter_todo_app/widgets/todo_title.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TodoViewmodel>();
    return Scaffold(
      appBar: AppBar(title: Text("Todo App")),
      
      body: Padding(
        padding: const EdgeInsets.all(16),
        
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Enter Task",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<TodoViewmodel>().addTodo(controller.text);
                  controller.clear();
                },
                child: const Text("Add Task"),
              ),
            ),
            const SizedBox(height: 15,),
            Expanded(
              child: ListView.builder(
                itemCount: vm.todos.length,
                itemBuilder : (context , index){
                  return TodoTitle(
                    todo: vm.todos[index],
                    index: index,
                    
                    );
                } 
                )
              ),
          ],
        ),
      ),
    );
  }
}
