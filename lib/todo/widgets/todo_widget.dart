import 'package:flutter/material.dart';

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
            onChanged: (bool? val) => {},
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
          )
        ],
      ),
    );
  }
}
