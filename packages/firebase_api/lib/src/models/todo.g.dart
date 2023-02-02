// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      id: json['id'] as int?,
      title: json['title'] as String,
      category: json['category'] as String,
      when: DateTime.parse(json['when'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'isCompleted': instance.isCompleted,
      'title': instance.title,
      'category': instance.category,
      'when': instance.when.toIso8601String(),
    };
