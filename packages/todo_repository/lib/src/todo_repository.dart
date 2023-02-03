import 'dart:async';

import 'package:firebase_api/firebase_api.dart' hide Todo;
import 'package:firebase_api/firebase_api.dart' as firebase_api;

import 'package:todo_repository/todo_repository.dart';

class TodoRepository {
  TodoRepository({FirebaseApiClient? todoApiClient})
      : _todoApiClient = todoApiClient ?? FirebaseApiClient();

  final FirebaseApiClient _todoApiClient;

  Future<List<Todo>> getTodoList({DateTime? date}) async {
    final todoList = await _todoApiClient.getTodoList(
      date: date,
    );
    return todoList
        .map(
          (e) => Todo(
            id: e.id,
            title: e.title,
            category: e.category,
            when: e.when,
            isCompleted: e.isCompleted,
          ),
        )
        .toList();
  }

  Future<void> patchUpdateTodo({required Todo todo}) async {
    final parsedTodo = firebase_api.Todo.fromJson(todo.toJson());
    await _todoApiClient.patchUpdateTodo(todo: parsedTodo);
  }

  Future<void> postAddTodo({required Todo todo}) async {
    final parsedTodo = firebase_api.Todo.fromJson(todo.toJson());
    await _todoApiClient.postAddTodo(todo: parsedTodo);
  }
}
