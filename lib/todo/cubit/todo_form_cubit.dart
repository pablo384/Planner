import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:planner_app/todo/cubit/todo_cubit.dart';
import 'package:planner_app/todo/models/todo.dart';
import 'package:todo_repository/todo_repository.dart' hide Todo;
import 'package:todo_repository/todo_repository.dart' as todo_repository;

part 'todo_form_cubit.g.dart';
part 'todo_form_state.dart';

class TodoFormCubit extends HydratedCubit<TodoFormState> {
  TodoFormCubit(this._todoRepository) : super(TodoFormState());
  final TodoRepository _todoRepository;

  void titleChanged(String title) {
    emit(
      state.copyWith(
        todo: state.todo.copyWith(title: title),
      ),
    );
  }

  void categoryChanged(String category) {
    emit(
      state.copyWith(
        todo: state.todo.copyWith(category: category),
      ),
    );
  }

  void whenChanged(DateTime when) {
    emit(
      state.copyWith(
        todo: state.todo.copyWith(when: when),
      ),
    );
  }

  Future<void> saveTodo() async {
    emit(state.copyWith(status: TodoStatus.loading));

    try {
      final todoParsed = todo_repository.Todo.fromJson(state.todo.toJson());
      await _todoRepository.postAddTodo(todo: todoParsed);

      emit(
        state.copyWith(
          status: TodoStatus.success,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: TodoStatus.failure));
    }
  }

  @override
  TodoFormState fromJson(Map<String, dynamic> json) =>
      TodoFormState.fromJson(json);

  @override
  Map<String, dynamic> toJson(TodoFormState state) => state.toJson();
}
