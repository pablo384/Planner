import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_repository/todo_repository.dart' as todo_repository;
part 'todo.g.dart';

@JsonSerializable()
class Todo extends Equatable {
  const Todo({
    this.id,
    required this.title,
    required this.category,
    required this.when,
    this.isCompleted = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  factory Todo.fromRepository(todo_repository.Todo todo) {
    return Todo(
      id: todo.id,
      title: todo.title,
      category: todo.category,
      when: todo.when,
      isCompleted: todo.isCompleted,
    );
  }
  static List<Todo> fromRepositoryList(List<todo_repository.Todo> todos) {
    return todos.map(Todo.fromRepository).toList();
  }

  static List<Todo> fromJsonList(List<dynamic> list) =>
      list.map((e) => Todo.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  final String? id;
  @JsonKey(name: 'isCompleted')
  final bool isCompleted;
  @JsonKey(name: 'name')
  final String title;
  @JsonKey(name: 'categoryId')
  final String category;
  @JsonKey(name: 'date')
  final DateTime when;

  bool get isNotCompleted => !isCompleted;

  @override
  String toString() {
    return '$id,$title,$category';
  }

  @override
  List<Object?> get props => [
        id,
        isCompleted,
        title,
        category,
        when,
      ];

  Todo copyWith({
    String? id,
    bool? isCompleted,
    String? title,
    String? category,
    DateTime? when,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      when: when ?? this.when,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
