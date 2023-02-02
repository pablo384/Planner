import 'dart:async';

import 'package:firebase_api/firebase_api.dart' hide Todo;

import 'package:todo_repository/todo_repository.dart';

class TodoRepository {
  TodoRepository({FirebaseApiClient? todoApiClient})
      : _todoApiClient = todoApiClient ?? FirebaseApiClient();

  final FirebaseApiClient _todoApiClient;

  Future<List<Todo>> getTodoList() async {
    final todoList = await _todoApiClient.getTodoList();
    return todoList
        .map(
          (e) =>
              Todo(id: e.id, name: e.name, category: e.category, when: e.when),
        )
        .toList();
  }
}
