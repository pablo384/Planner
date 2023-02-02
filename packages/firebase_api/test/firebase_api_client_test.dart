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
      const baseUrlTodoApp = 'firestore.googleapis.com';
      const apiKey = 'AIzaSyAFZ2uyHiPuQQi_4wf8cUQpdMEMqGapq_Q';
      const headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjVhNTA5ZjAxOWY3MGQ3NzlkODBmMTUyZDFhNWQzMzgxMWFiN2NlZjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYXBwbGF1ZG8tdG9kby1hcHAiLCJhdWQiOiJhcHBsYXVkby10b2RvLWFwcCIsImF1dGhfdGltZSI6MTY3NTM2NzAwOCwidXNlcl9pZCI6IllWM1BkRTRlenZkcUl3dlU5RGVFdFhXZDN4QzMiLCJzdWIiOiJZVjNQZEU0ZXp2ZHFJd3ZVOURlRXRYV2QzeEMzIiwiaWF0IjoxNjc1MzY3MDA4LCJleHAiOjE2NzUzNzA2MDgsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0ZXN0QHRlc3QuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.nhHyGZEHyF6qDomqYRf_Jt4sJ9xn0ip57zxKLa9CIrnCxa52xphPTBKaNnXzy3MCM4DLji7gNUupt3ZUvueOYM4tslpIY-INqcRiln1JvdOS4GFcA2zkBIBmYOiy5P81rs78UKGV5bry9TZBtYQtOktZCIRXz7mOkE-_XYDhZuf7X2PSTz5z7Q0gMfIWYsSrLujpAMdUpJKGc6Tv45brpvdkTH_ks2KkD7u4MVzB6tqBuUopQHdb5OHRTBd0ge0RSrecrUd0wPYilhrwdClTGOaf8se3oc8ADM3nCt8KV-lcJCYuH-nhLCyd3b4ArAvvpSeiSBzZRAiafOR7yDru9w',
      };
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
              baseUrlTodoApp,
              '/v1/projects/applaudo-todo-app/databases/(default)/documents/tasks',
              {
                'key': apiKey,
              },
            ),
            headers: headers,
          ),
        ).called(1);
      });

      test('throws TodoRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(
          () => httpClient.get(
            Uri.https(
              baseUrlTodoApp,
              '/v1/projects/applaudo-todo-app/databases/(default)/documents/tasks',
              {
                'key': apiKey,
              },
            ),
            headers: headers,
          ),
        ).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getTodoList(),
          throwsA(isA<TodoRequestFailure>()),
        );
      });

      test('throws TodoListNotFoundFailure on error response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(
          () => httpClient.get(
            Uri.https(
              baseUrlTodoApp,
              '/v1/projects/applaudo-todo-app/databases/(default)/documents/tasks',
              {
                'key': apiKey,
              },
            ),
            headers: headers,
          ),
        ).thenAnswer((_) async => response);
        await expectLater(
          apiClient.getTodoList(),
          throwsA(isA<TodoListNotFoundFailure>()),
        );
      });

      test('throws TodoListNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"results": []}');
        when(
          () => httpClient.get(
            Uri.https(
              baseUrlTodoApp,
              '/v1/projects/applaudo-todo-app/databases/(default)/documents/tasks',
              {
                'key': apiKey,
              },
            ),
            headers: headers,
          ),
        ).thenAnswer((_) async => response);
        await expectLater(
          apiClient.getTodoList(),
          throwsA(isA<TodoListNotFoundFailure>()),
        );
      });

      test('returns Todo on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
  {
    "documents": [
        {
            "name": "projects/applaudo-todo-app/databases/(default)/documents/tasks/iR8ZYMNfrB5xNU8SA5rK",
            "fields": {
                "date": {
                    "integerValue": "1664072803"
                },
                "categoryId": {
                    "stringValue": " DDQeCPpZATcLfV9U3I0v"
                },
                "name": {
                    "stringValue": "wedding"
                },
                "isCompleted": {
                    "booleanValue": false
                }
            },
            "createTime": "2022-07-24T20:25:55.703502Z",
            "updateTime": "2022-07-24T20:27:21.923171Z"
        }
    ]
  }''',
        );
        when(
          () => httpClient.get(
            Uri.https(
              baseUrlTodoApp,
              '/v1/projects/applaudo-todo-app/databases/(default)/documents/tasks',
              {
                'key': apiKey,
              },
            ),
            headers: headers,
          ),
        ).thenAnswer((_) async => response);
        final actual = await apiClient.getTodoList();
        expect(actual, isA<List<Todo>>());
      });
    });
  });
}
