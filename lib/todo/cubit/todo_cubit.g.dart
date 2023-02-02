// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoState _$TodoStateFromJson(Map<String, dynamic> json) => TodoState(
      status: $enumDecodeNullable(_$TodoStatusEnumMap, json['status']) ??
          TodoStatus.initial,
      todoList: (json['todoList'] as List<dynamic>?)
          ?.map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodoStateToJson(TodoState instance) => <String, dynamic>{
      'status': _$TodoStatusEnumMap[instance.status]!,
      'todoList': instance.todoList,
    };

const _$TodoStatusEnumMap = {
  TodoStatus.initial: 'initial',
  TodoStatus.loading: 'loading',
  TodoStatus.success: 'success',
  TodoStatus.failure: 'failure',
};
