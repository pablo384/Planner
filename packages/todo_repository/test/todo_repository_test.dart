// ignore_for_file: prefer_const_constructors
import 'package:firebase_api/firebase_api.dart' as firebase_api;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_repository/todo_repository.dart';

class MocFirebaseApiClient extends Mock
    implements firebase_api.FirebaseApiClient {}

class MockTodo extends Mock implements firebase_api.Todo {}

void main() {
  group('TodoRepository', () {
    late firebase_api.FirebaseApiClient todoApiClient;
    late TodoRepository todoRepository;

    setUp(() {
      todoApiClient = MocFirebaseApiClient();
      todoRepository = TodoRepository(
        todoApiClient: todoApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal firebase api client when not injected', () {
        expect(TodoRepository(), isNotNull);
      });
    });

    group('getTodoList', () {
      const id = 1234;
      const name = 'Todo name';
      const category = 'Funny Things';
      final mocWhen = DateTime.now();

      test('calls getTodoList', () async {
        try {
          await todoRepository.getTodoList();
        } catch (_) {}
        verify(() => todoApiClient.getTodoList()).called(1);
      });

      test('throws when getTodoList fails', () async {
        final exception = Exception('oops');
        when(() => todoApiClient.getTodoList()).thenThrow(exception);
        expect(
          () async => todoRepository.getTodoList(),
          throwsA(exception),
        );
      });

      test('returns correct TodoList on success', () async {
        final todo = MockTodo();
        when(() => todo.id).thenReturn(id);
        when(() => todo.name).thenReturn(name);
        when(() => todo.category).thenReturn(category);
        when(() => todo.when).thenReturn(mocWhen);
        when(() => todoApiClient.getTodoList()).thenAnswer(
          (_) async => [todo],
        );

        final actual = await todoRepository.getTodoList();
        expect(
          actual[0],
          Todo(
            id: id,
            name: name,
            category: category,
            when: mocWhen,
          ),
        );
      });
    });
  });
}
