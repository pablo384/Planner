import 'package:flutter/material.dart';
import 'package:planner_app/todo/view/todo_view.dart';

class PlannerApp extends StatelessWidget {
  const PlannerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planner',
      home: Builder(builder: (context) {
        return const TodoPage();
      }),
    );
  }
}
