import 'package:flutter/material.dart';
import 'package:planner_app/todo/widgets/todo_widget.dart';

class TodoSectionWidget extends StatelessWidget {
  const TodoSectionWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const TodoWidget()
      ],
    );
  }
}
