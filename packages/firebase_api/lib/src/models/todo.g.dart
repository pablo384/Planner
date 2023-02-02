// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      id: json['id'] as String?,
      title: json['name'] as String,
      category: json['categoryId'] as String,
      when: DateTime.parse(json['date'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'isCompleted': instance.isCompleted,
      'name': instance.title,
      'categoryId': instance.category,
      'date': instance.when.toIso8601String(),
    };
