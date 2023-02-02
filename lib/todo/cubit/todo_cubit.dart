import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:planner_app/todo/models/models.dart';
import 'package:todo_repository/todo_repository.dart' hide Todo;
import 'package:todo_repository/todo_repository.dart' as todo_repository;

part 'todo_cubit.g.dart';
part 'todo_state.dart';

class TodoCubit extends HydratedCubit<TodoState> {
  TodoCubit(this._todoRepository) : super(TodoState());

  final TodoRepository _todoRepository;

  Future<void> fetchTodoList() async {
    emit(state.copyWith(status: TodoStatus.loading));

    try {
      final todos = Todo.fromRepositoryList(
        await _todoRepository.getTodoList(
          date: state.date,
        ),
      );

      emit(
        state.copyWith(
          status: TodoStatus.success,
          todoList: todos,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: TodoStatus.failure));
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await _todoRepository.postUpdateTodo(
        todo: todo_repository.Todo.fromJson(
          todo.toJson(),
        ),
      );
      await refreshTodoList();
    } on Exception {
      emit(state);
    }
  }

  Future<void> setSelectedDate(DateTime selectedDate) async {
    try {
      emit(state.copyWith(date: selectedDate));
      await fetchTodoList();
    } on Exception {
      emit(state);
    }
  }

  Future<void> refreshTodoList() async {
    if (!state.status.isSuccess) return;
    if (state.todoList.isEmpty) return;

    try {
      final todos = Todo.fromRepositoryList(
        await _todoRepository.getTodoList(
          date: state.date,
        ),
      );

      emit(
        state.copyWith(
          status: TodoStatus.success,
          todoList: todos,
        ),
      );
    } on Exception {
      emit(state);
    }
  }

  @override
  TodoState fromJson(Map<String, dynamic> json) => TodoState.fromJson(json);

  @override
  Map<String, dynamic> toJson(TodoState state) => state.toJson();
}
