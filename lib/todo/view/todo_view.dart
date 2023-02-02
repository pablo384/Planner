import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:planner_app/todo/cubit/todo_cubit.dart';
import 'package:planner_app/todo/models/todo.dart';
import 'package:planner_app/todo/view/add_todo_view.dart';

import 'package:planner_app/todo/widgets/header_widget.dart';
import 'package:planner_app/todo/widgets/todo_section_widget.dart';
import 'package:todo_repository/todo_repository.dart' hide Todo;

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(context.read<TodoRepository>()),
      child: const TodoView(),
    );
  }
}

class TodoView extends StatefulWidget {
  const TodoView({
    super.key,
  });

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  void initState() {
    super.initState();
    context.read<TodoCubit>().fetchTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: BlocConsumer<TodoCubit, TodoState>(
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.status) {
                  case TodoStatus.initial:
                    return const TodoEmpty();
                  case TodoStatus.loading:
                    return const TodoLoading();
                  case TodoStatus.success:
                    return TodoPopulated(
                      todoList: state.todoList,
                      onRefresh: () {
                        return context.read<TodoCubit>().refreshTodoList();
                      },
                    );
                  case TodoStatus.failure:
                    return const TodoError();
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await Navigator.of(context).push(AddTodoPage.route());
          await context.read<TodoCubit>().refreshTodoList();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class TodoPopulated extends StatelessWidget {
  const TodoPopulated({
    super.key,
    required this.todoList,
    required this.onRefresh,
  });

  final List<Todo> todoList;
  final Function onRefresh;
  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMMd().format(DateTime.now());
    return Column(
      children: [
        HeaderWidget(date: date),
        const TodoSectionWidget(
          title: 'Incomplete',
        ),
        ...todoList.map((e) => Text(e.name)).toList(),
      ],
    );
  }
}

class TodoEmpty extends StatelessWidget {
  const TodoEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    // final date = DateFormat.yMMMMd().format(DateTime.now());
    return Column(
      children: const [
        Text('Empty'),
      ],
    );
  }
}

class TodoLoading extends StatelessWidget {
  const TodoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class TodoError extends StatelessWidget {
  const TodoError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Op!'),
    );
  }
}
