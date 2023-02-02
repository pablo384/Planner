import 'package:flutter/material.dart';
import 'package:planner_app/todo/models/todo.dart';
import 'package:planner_app/todo/widgets/todo_widget.dart';

class TodoSectionWidget extends StatelessWidget {
  const TodoSectionWidget({
    super.key,
    required this.completedTodo,
    required this.incompleteTodo,
  });

  final List<Todo> completedTodo;
  final List<Todo> incompleteTodo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Incomplete',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        ...incompleteTodo
            .map(
              (e) => TodoWidget(
                todo: e,
              ),
            )
            .toList(),
        Text(
          'Completed',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        ...completedTodo
            .map(
              (e) => TodoWidget(
                todo: e,
              ),
            )
            .toList(),
      ],
    );
  }
}
