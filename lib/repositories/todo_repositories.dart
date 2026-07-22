

import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:flutter_todo_app/services/api_service.dart';

class TodoRepositories {
  final ApiService apiService;
  TodoRepositories(this.apiService);

  // get all todo

  Future<List<TodoModel>> getTodos() async {
    final response = await apiService.get('todos');
    final List data = response.data['data'];

    return data
        .map((json) => TodoModel.fromJson(json))
        .toList();
  }
}
