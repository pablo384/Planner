import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_app/todo/cubit/todo_form_cubit.dart';
import 'package:planner_app/todo/widgets/todo_form_widget.dart';
import 'package:todo_repository/todo_repository.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  const AddTodoPage._();

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const AddTodoPage._());
  }

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoFormCubit(context.read<TodoRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('To go back'),
          centerTitle: false,
        ),
        body: const SafeArea(
          child: TodoFormWidget(),
        ),
      ),
    );
  }
}
