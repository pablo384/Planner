// ignore_for_file: flutter_style_todos

import 'dart:async';
import 'dart:convert';

import 'package:firebase_api/firebase_api.dart';
import 'package:http/http.dart' as http;

/// Exception thrown when Todo Get fails.
class TodoRequestFailure implements Exception {}

/// Exception thrown when the provided Todo List is not found.
class TodoListNotFoundFailure implements Exception {}

final List<Todo> todoList = [
  Todo(
    id: 123,
    title: 'First Todo 🥳',
    category: 'Fun',
    when: DateTime.now(),
    isCompleted: false,
  ),
  Todo(
    id: 1234,
    title: 'First Todo 🥳',
    category: 'Fun',
    when: DateTime.now(),
    isCompleted: false,
  ),
];

/// {@template firebase_todo_api_client}
/// Dart API Client which wraps the [Firebase Todo API](https://firestore.googleapis.com/v1/projects/applaudo-todo-app/databases/).
/// {@endtemplate}
class FirebaseApiClient {
  /// {@macro firebase_todo_api_client}
  FirebaseApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrlTodoApp = 'firestore.googleapis.com';

  final http.Client _httpClient;

  /// Get a list [Todo] `/documents/tasks`.
  Future<List<Todo>> getTodoList({DateTime? date}) async {
    // final todoRequest = Uri.https(
    //   _baseUrlTodoApp,
    //   '/v1/projects/applaudo-todo-app/databases/(default)/documents/tasks',
    // );

    // final todoListResponse = await _httpClient.get(todoRequest);

    // if (todoListResponse.statusCode != 200) {
    //   throw TodoRequestFailure();
    // }

    // final todoListJson = jsonDecode(todoListResponse.body) as Map;

    // if (!todoListJson.containsKey('results')) throw TodoListNotFoundFailure();

    // final results = todoListJson['results'] as List;

    // if (results.isEmpty) throw TodoListNotFoundFailure();

    await Future.delayed(Duration(seconds: 1));
    return todoList;
    // return Todo.fromJsonList(results);
  }

  Future<void> postUpdateTodo({required Todo todo}) async {
    // final todoRequest = Uri.https(
    //   _baseUrlTodoApp,
    //   '/v1/projects/applaudo-todo-app/databases/(default)/documents/tasks',
    // );

    // final todoListResponse = await _httpClient.get(todoRequest);

    // if (todoListResponse.statusCode != 200) {
    //   throw TodoRequestFailure();
    // }
    todoList.removeWhere((element) => element.id == todo.id);
    todoList.add(todo);
  }

  Future<void> postAddTodo({required Todo todo}) async {
    todoList.add(todo);
  }
}
