// ignore_for_file: avoid_dynamic_calls

import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  const Todo({
    this.id,
    required this.title,
    required this.category,
    required this.when,
    this.isCompleted = false,
  });

  factory Todo.parseJsonResponse(Map<String, dynamic> obj) {
    final fields = obj['fields'] as Map<String, dynamic>;
    final res = Todo(
      id: obj['name'].toString(),
      title: fields['name']['stringValue'].toString(),
      category: fields['categoryId']['stringValue'].toString(),
      isCompleted: fields['isCompleted']['booleanValue'] as bool,
      when: DateTime.fromMillisecondsSinceEpoch(
        int.tryParse(
              fields['date']['integerValue'].toString(),
            ) ??
            0,
      ),
    );
    return res;
  }

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> parseToJsonRequest() {
    // ignore: omit_local_variable_types
    final Map<String, dynamic> fields = {
      'name': {'stringValue': title},
      'categoryId': {'stringValue': category},
      'isCompleted': {'booleanValue': isCompleted},
      'date': {'integerValue': when.millisecondsSinceEpoch.toString()},
    };
    return {'fields': fields};
  }

  static List<Todo> fromJsonList(List<dynamic> list) =>
      list.map((e) => Todo.fromJson(e as Map<String, dynamic>)).toList();

  static List<Todo> fromJsonListResponse(List<dynamic> list) {
    return list
        .where((e) => e['fields'] != null)
        .map((e) => Todo.parseJsonResponse(e as Map<String, dynamic>))
        .toList();
  }

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
  String toString() {
    return '$id,$title,$category,$isCompleted';
  }
}
