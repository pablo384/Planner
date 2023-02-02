part of 'todo_cubit.dart';

@JsonSerializable()
class TodoState extends Equatable {
  TodoState({
    this.status = TodoStatus.initial,
    List<Todo>? todoList,
  }) : todoList = todoList ?? [];

  factory TodoState.fromJson(Map<String, dynamic> json) =>
      _$TodoStateFromJson(json);

  final TodoStatus status;
  final List<Todo> todoList;

  @override
  List<Object?> get props => [status, todoList];

  TodoState copyWith({
    TodoStatus? status,
    List<Todo>? todoList,
  }) {
    return TodoState(
      status: status ?? this.status,
      todoList: todoList ?? this.todoList,
    );
  }

  Map<String, dynamic> toJson() => _$TodoStateToJson(this);
}

enum TodoStatus { initial, loading, success, failure }

extension TodoStatusX on TodoStatus {
  bool get isFailure => this == TodoStatus.failure;
  bool get isInitial => this == TodoStatus.initial;
  bool get isLoading => this == TodoStatus.loading;
  bool get isSuccess => this == TodoStatus.success;
}
