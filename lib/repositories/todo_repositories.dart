import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:flutter_todo_app/services/api_service.dart';

class TodoRepositories {
  final ApiService apiService;
  TodoRepositories(this.apiService);

  // get all todo

  Future<List<TodoModel>> getTodos() async {
    final response = await apiService.get('todo');
    final List data = response.data['todos'];

    return data.map((json) => TodoModel.fromJson(json)).toList();
  }

  // create new todo

  Future<TodoModel> createTodo(String title) async {
    final response = await apiService.post('todo', data: {'title': title});
    return TodoModel.fromJson(response.data['todo']);
  }

  Future<TodoModel> editTodo(String id, String title) async {
    final response = await apiService.put(
      'todo/$id', data: {'title': title}
      );
    return TodoModel.fromJson(response.data['todo']);
  }
}
