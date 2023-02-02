import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_repository/todo_repository.dart' as todo_repository;
part 'todo.g.dart';

@JsonSerializable()
class Todo extends Equatable {
  const Todo({
    required this.id,
    required this.name,
    required this.category,
    required this.when,
    this.isCompleted = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  factory Todo.fromRepository(todo_repository.Todo todo) {
    return Todo(
      id: todo.id,
      name: todo.name,
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

  final int id;
  final bool isCompleted;
  final String name;
  final String category;
  final DateTime when;

  @override
  String toString() {
    return '$id,$name,$category';
  }

  @override
  List<Object?> get props => [
        id,
        isCompleted,
        name,
        category,
        when,
      ];

  Todo copyWith({
    int? id,
    bool? isCompleted,
    String? name,
    String? category,
    DateTime? when,
  }) {
    return Todo(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      when: when ?? this.when,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
