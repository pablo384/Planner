import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

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

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  static List<Todo> fromJsonList(List<dynamic> list) =>
      list.map((e) => Todo.fromJson(e as Map<String, dynamic>)).toList();

  final String? id;
  @JsonKey(name: 'isCompleted')
  final bool isCompleted;
  @JsonKey(name: 'name')
  final String title;
  @JsonKey(name: 'categoryId')
  final String category;
  @JsonKey(name: 'date')
  final DateTime when;

  @override
  List<Object?> get props => [
        id,
        isCompleted,
        title,
        category,
        when,
      ];
}
