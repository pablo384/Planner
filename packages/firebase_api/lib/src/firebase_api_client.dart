// ignore_for_file: flutter_style_todos

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_api/firebase_api.dart';
import 'package:http/http.dart' as http;

/// Exception thrown when Todo Get fails.
class TodoRequestFailure implements Exception {}

/// Exception thrown when the provided Todo List is not found.
class TodoListNotFoundFailure implements Exception {}

/// {@template firebase_todo_api_client}
/// Dart API Client which wraps the [Firebase Todo API](https://firestore.googleapis.com/v1/projects/applaudo-todo-app/databases/).
/// {@endtemplate}
class FirebaseApiClient {
  /// {@macro firebase_todo_api_client}
  FirebaseApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrlTodoApp = 'firestore.googleapis.com';
  static const _apiKey = 'AIzaSyAFZ2uyHiPuQQi_4wf8cUQpdMEMqGapq_Q';
  static const _headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjVhNTA5ZjAxOWY3MGQ3NzlkODBmMTUyZDFhNWQzMzgxMWFiN2NlZjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYXBwbGF1ZG8tdG9kby1hcHAiLCJhdWQiOiJhcHBsYXVkby10b2RvLWFwcCIsImF1dGhfdGltZSI6MTY3NTM2NzAwOCwidXNlcl9pZCI6IllWM1BkRTRlenZkcUl3dlU5RGVFdFhXZDN4QzMiLCJzdWIiOiJZVjNQZEU0ZXp2ZHFJd3ZVOURlRXRYV2QzeEMzIiwiaWF0IjoxNjc1MzY3MDA4LCJleHAiOjE2NzUzNzA2MDgsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0ZXN0QHRlc3QuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.nhHyGZEHyF6qDomqYRf_Jt4sJ9xn0ip57zxKLa9CIrnCxa52xphPTBKaNnXzy3MCM4DLji7gNUupt3ZUvueOYM4tslpIY-INqcRiln1JvdOS4GFcA2zkBIBmYOiy5P81rs78UKGV5bry9TZBtYQtOktZCIRXz7mOkE-_XYDhZuf7X2PSTz5z7Q0gMfIWYsSrLujpAMdUpJKGc6Tv45brpvdkTH_ks2KkD7u4MVzB6tqBuUopQHdb5OHRTBd0ge0RSrecrUd0wPYilhrwdClTGOaf8se3oc8ADM3nCt8KV-lcJCYuH-nhLCyd3b4ArAvvpSeiSBzZRAiafOR7yDru9w',
  };

  final http.Client _httpClient;

  /// Get a list [Todo] `/documents/tasks`.
  Future<List<Todo>> getTodoList({DateTime? date}) async {
    final todoRequest = Uri.https(
      _baseUrlTodoApp,
      '/v1/projects/applaudo-todo-app/databases/(default)/documents/tasks',
      {
        'key': _apiKey,
      },
    );

    final todoListResponse = await _httpClient.get(
      todoRequest,
      headers: _headers,
    );

    if (todoListResponse.statusCode != 200) {
      throw TodoRequestFailure();
    }

    final todoListJson = jsonDecode(todoListResponse.body) as Map;

    if (!todoListJson.containsKey('documents')) throw TodoListNotFoundFailure();

    final results = todoListJson['documents'] as List;
    if (results.isEmpty) throw TodoListNotFoundFailure();

    return Todo.fromJsonListResponse(results);
  }

  Future<void> patchUpdateTodo({required Todo todo}) async {
    final todoRequest = Uri.https(
      _baseUrlTodoApp,
      '/v1/${todo.id}',
      {
        'key': _apiKey,
      },
    );
    final todoResponse = await _httpClient.patch(
      todoRequest,
      headers: _headers,
      body: json.encode(todo.parseToJsonRequest()),
    );

    if (todoResponse.statusCode != 200) {
      throw TodoRequestFailure();
    }
  }

  Future<void> postAddTodo({required Todo todo}) async {
    final todoRequest = Uri.https(
      _baseUrlTodoApp,
      '/v1/projects/applaudo-todo-app/databases/(default)/documents/tasks',
      {
        'key': _apiKey,
      },
    );
    final todoResponse = await _httpClient.patch(
      todoRequest,
      headers: _headers,
      body: json.encode(todo.parseToJsonRequest()),
    );

    if (todoResponse.statusCode != 200) {
      throw TodoRequestFailure();
    }
  }
}
