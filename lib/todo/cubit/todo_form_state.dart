part of 'todo_form_cubit.dart';

@JsonSerializable()
class TodoFormState extends Equatable {
  TodoFormState({
    this.status = TodoStatus.initial,
    Todo? todo,
  }) : todo = todo ??
            Todo(
              title: '',
              category: '',
              when: DateTime.now(),
            );

  factory TodoFormState.fromJson(Map<String, dynamic> json) =>
      _$TodoFormStateFromJson(json);

  final TodoStatus status;
  final Todo todo;

  @override
  List<Object?> get props => [status, todo];

  TodoFormState copyWith({
    TodoStatus? status,
    Todo? todo,
  }) {
    return TodoFormState(
      status: status ?? this.status,
      todo: todo ?? this.todo,
    );
  }

  Map<String, dynamic> toJson() => _$TodoFormStateToJson(this);
}
