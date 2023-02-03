// ignore_for_file: flutter_style_todos

import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
  static Map<String, String> get _headers {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return {};
    }
    return {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjVhNTA5ZjAxOWY3MGQ3NzlkODBmMTUyZDFhNWQzMzgxMWFiN2NlZjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYXBwbGF1ZG8tdG9kby1hcHAiLCJhdWQiOiJhcHBsYXVkby10b2RvLWFwcCIsImF1dGhfdGltZSI6MTY3NTQwMDUzNSwidXNlcl9pZCI6IllWM1BkRTRlenZkcUl3dlU5RGVFdFhXZDN4QzMiLCJzdWIiOiJZVjNQZEU0ZXp2ZHFJd3ZVOURlRXRYV2QzeEMzIiwiaWF0IjoxNjc1NDAwNTM1LCJleHAiOjE2NzU0MDQxMzUsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0ZXN0QHRlc3QuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.I0k2HTCQXL-SgwcZhLmaIlXtBH0yCAYHmQ6pO0Sq5R0_1_Rj9gwY0fPZ6bNNHkumxV5xyb6391pwWzDOqYAaOSYljFt9_5lZOtr51YfYUL_zZYHzhnfZSBOiwCcFTnzDaptPkOM_1nTQ0EIiHErhE_VGKpIOv_39UJo4MhtQvhxIdmZlsVk8_CIR4pBOnbrBH8iIvt2NDCdQHhfJ-6qKCZ6V_AP83ew_0oJx71eaErANfa0a5PsCTr99e1jP8KWf_DrV7BxvE_B0zdUGxvUrcuT0UoyRhMUj_--5qmne3SkEoH0yRbYjr2zWfx7jDWxzPyCLqt_1coNdE1bRy1rgNg',
    };
  }

  final http.Client _httpClient;

  /// Get a list [Todo] `/documents/tasks`.
  Future<List<Todo>> getTodoList({DateTime? date}) async {
    final todoRequest = Uri.https(
      _baseUrlTodoApp,
      '/v1/projects/applaudo-todo-app/databases/(default)/documents/tasks',
      {
        'key': _apiKey,
        'pageSize': '100000',
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

    return Todo.fromJsonListResponse(results)
        .where(
          // ignore: avoid_bool_literals_in_conditional_expressions
          (todoItem) => date != null ? todoItem.when.isSameDate(date) : true,
        )
        .toList();
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

    final todoResponse = await _httpClient.post(
      todoRequest,
      headers: _headers,
      body: json.encode(todo.parseToJsonRequest()),
    );

    if (todoResponse.statusCode != 200) {
      throw TodoRequestFailure();
    }
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
