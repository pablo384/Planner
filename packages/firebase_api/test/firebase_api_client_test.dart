// ignore_for_file: prefer_const_constructors
import 'package:firebase_api/firebase_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('FirebaseApiClient', () {
    late http.Client httpClient;
    late FirebaseApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = FirebaseApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(FirebaseApiClient(), isNotNull);
      });
    });

    group('getTodoList', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.getTodoList();
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'firestore.googleapis.com',
              '/v1/projects/applaudo-todo-app/databases/(default)/documents/tasks',
            ),
          ),
        ).called(1);
      });

      test('throws TodoRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getTodoList(),
          throwsA(isA<TodoRequestFailure>()),
        );
      });

      test('throws TodoListNotFoundFailure on error response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.getTodoList(),
          throwsA(isA<TodoListNotFoundFailure>()),
        );
      });

      test('throws TodoListNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"results": []}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.getTodoList(),
          throwsA(isA<TodoListNotFoundFailure>()),
        );
      });

      test('returns Todo on valid response', () async {
        final mocWhenDate = DateTime.now();
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
  {
    "results": [
      {
        "id": 1234,
        "name": "Run an app",
        "category": "Development 👨‍💻",
        "when": "${mocWhenDate.toIso8601String()}"
      }
    ]
  }''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.getTodoList();
        expect(actual, isA<List<Todo>>());
      });
    });
  });
}
