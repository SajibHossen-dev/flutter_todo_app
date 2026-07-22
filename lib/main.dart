import 'package:flutter/material.dart';
import 'package:flutter_todo_app/repositories/todo_repositories.dart';
import 'package:flutter_todo_app/services/api_service.dart';
import 'package:flutter_todo_app/viewmodels/todo_viewmodel.dart';
import 'package:flutter_todo_app/views/auth/login_page.dart';
import 'package:flutter_todo_app/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  final apiService = ApiService();
  final todoRepositories = TodoRepositories(apiService);

  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoViewmodel(
        todoRepositories,
      )..loadTodos(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("todo app"),
      ),
      body: Center(child: Text("This is todo app")),
    );
  }
}
