import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planner_app/todo/cubit/todo_cubit.dart';
import 'package:todo_repository/todo_repository.dart' as todo_repository;

import '../../helpers/hydrated_bloc.dart';

const todoTitle = 'Title';
const todoCategory = 'Category';
final todoWhen = DateTime.now();

class MockTodoCubit extends MockCubit<TodoState> implements TodoCubit {}

class MockTodoRepository extends Mock
    implements todo_repository.TodoRepository {}

class MockTodo extends Mock implements todo_repository.Todo {}

void main() {
  initHydratedStorage();

  group('TodoCubit', () {
    late todo_repository.Todo todo;
    late todo_repository.TodoRepository todoRepository;
    late TodoCubit todoCubit;

    setUp(() async {
      todo = MockTodo();
      todoRepository = MockTodoRepository();
      when(() => todo.title).thenReturn(todoTitle);
      when(() => todo.category).thenReturn(todoCategory);
      when(() => todo.when).thenReturn(todoWhen);
      when(
        () => todoRepository.getTodoList(),
      ).thenAnswer((_) async => [todo]);
      todoCubit = TodoCubit(todoRepository);
    });
    test('initial state is correct', () {
      final todoCubit = TodoCubit(todoRepository);
      expect(
        todoCubit.state,
        TodoState(
          date: todoCubit.state.date,
        ),
      );
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        final todoCubit = TodoCubit(todoRepository);
        expect(
          todoCubit.fromJson(todoCubit.toJson(todoCubit.state)),
          todoCubit.state,
        );
      });
    });
  });
}
