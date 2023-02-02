import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_app/todo/view/todo_view.dart';
import 'package:todo_repository/todo_repository.dart';

class PlannerApp extends StatelessWidget {
  const PlannerApp({super.key, required TodoRepository todoRepository})
      : _todoRepository = todoRepository;

  final TodoRepository _todoRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _todoRepository,
      child: MaterialApp(
        title: 'Planner',
        home: Builder(builder: (context) {
          return const TodoPage();
        }),
      ),
    );
  }
}
