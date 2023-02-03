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
          'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjVhNTA5ZjAxOWY3MGQ3NzlkODBmMTUyZDFhNWQzMzgxMWFiN2NlZjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYXBwbGF1ZG8tdG9kby1hcHAiLCJhdWQiOiJhcHBsYXVkby10b2RvLWFwcCIsImF1dGhfdGltZSI6MTY3NTM5NDQzOSwidXNlcl9pZCI6IllWM1BkRTRlenZkcUl3dlU5RGVFdFhXZDN4QzMiLCJzdWIiOiJZVjNQZEU0ZXp2ZHFJd3ZVOURlRXRYV2QzeEMzIiwiaWF0IjoxNjc1Mzk0NDM5LCJleHAiOjE2NzUzOTgwMzksImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0ZXN0QHRlc3QuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.YQuDp-bQE29ijYcJciKm7a1jBQkt1kWOiW2BdC_4wnHEBYsTrkek9MChUuqcc66MpSq7IH1XDis6flx3Iwm5W3_q1C9mm2oYMrydKSMGTZxpYikjSXNWEA7l43qKGYZRgKIUQpAusGRSqitxo2D5OJ-nIt-2SQXtkucCrBiM8_UUQxflIJJfEa9sk_At7nMSvcH7BMznpDj9vKVttSlmCD4Jh2YEOEhfgSc8oGQD_wa5i4A3kWMnxEbZUxPz032P4qOZRnl1WM-w67o-KUjw0oUgZxnxkBoM9yhaMbgF9n3CArrK8yRImAA0beKZBzDFdpl1w5DFn6L500NeRafOwQ',
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
