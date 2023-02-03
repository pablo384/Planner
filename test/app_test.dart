import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planner_app/app.dart';
import 'package:planner_app/todo/cubit/todo_cubit.dart';
import 'package:planner_app/todo/view/todo_view.dart';
import 'package:todo_repository/todo_repository.dart';

import 'helpers/hydrated_bloc.dart';

class MockTodoCubit extends MockCubit<TodoState> implements TodoCubit {}

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  initHydratedStorage();

  group('PlannerApp', () {
    late TodoRepository todoRepository;

    setUp(() {
      todoRepository = MockTodoRepository();
    });

    testWidgets('renders TodoPage', (tester) async {
      await tester.pumpWidget(
        PlannerApp(todoRepository: todoRepository),
      );
      expect(find.byType(TodoPage), findsOneWidget);
    });
  });

  group('TodoView', () {
    late TodoCubit todoCubit;
    late TodoRepository todoRepository;

    setUp(() {
      todoCubit = MockTodoCubit();
      todoRepository = MockTodoRepository();
    });

    testWidgets('renders TodoView', (tester) async {
      when(() => todoCubit.state).thenReturn(TodoState());
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: todoRepository,
          child: BlocProvider.value(
            value: todoCubit,
            child: const TodoView(),
          ),
        ),
      );
      expect(find.byType(TodoEmpty), findsOneWidget);
    });
  });
}
