// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_form_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoFormState _$TodoFormStateFromJson(Map<String, dynamic> json) =>
    TodoFormState(
      status: $enumDecodeNullable(_$TodoStatusEnumMap, json['status']) ??
          TodoStatus.initial,
      todo: json['todo'] == null
          ? null
          : Todo.fromJson(json['todo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TodoFormStateToJson(TodoFormState instance) =>
    <String, dynamic>{
      'status': _$TodoStatusEnumMap[instance.status]!,
      'todo': instance.todo,
    };

const _$TodoStatusEnumMap = {
  TodoStatus.initial: 'initial',
  TodoStatus.loading: 'loading',
  TodoStatus.success: 'success',
  TodoStatus.failure: 'failure',
};
