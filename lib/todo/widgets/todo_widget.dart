import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_app/todo/cubit/todo_cubit.dart';
import 'package:planner_app/todo/models/todo.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Checkbox(
            value: todo.isCompleted,
            onChanged: (bool? val) => {
              context.read<TodoCubit>().updateTodo(
                    todo.copyWith(
                      isCompleted: val,
                    ),
                  )
            },
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: todo.isCompleted ? Colors.black45 : null,
                      ),
                ),
                Text(
                  todo.category,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black45,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
