import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_app/todo/cubit/todo_form_cubit.dart';

class TodoFormWidget extends StatefulWidget {
  const TodoFormWidget({
    super.key,
  });

  @override
  State<TodoFormWidget> createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<TodoFormWidget> {
  final TextEditingController _textDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _textDateController.dispose();
    super.dispose();
  }

  String? validator(String? val) {
    if (val == null || val.isEmpty) return 'This field is required';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> onTabDateSelected() async {
      final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );
      if (selectedDate != null) {
        // ignore: use_build_context_synchronously
        context.read<TodoFormCubit>().whenChanged(selectedDate);
      }
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Task',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: validator,
              onChanged: (String? val) {
                if (val != null) {
                  context.read<TodoFormCubit>().titleChanged(val);
                }
              },
            ),
            TextFormField(
              validator: validator,
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
              onChanged: (String? val) {
                if (val != null) {
                  context.read<TodoFormCubit>().categoryChanged(val);
                }
              },
            ),
            BlocConsumer<TodoFormCubit, TodoFormState>(
              listener: (context, state) {
                _textDateController.text = state.dateToShow;
              },
              builder: (context, state) {
                return TextFormField(
                  keyboardType: TextInputType.datetime,
                  enabled: true,
                  validator: validator,
                  controller: _textDateController,
                  onTap: onTabDateSelected,
                  decoration: InputDecoration(
                    labelText: 'When',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month_outlined),
                      onPressed: onTabDateSelected,
                    ),
                  ),
                );
              },
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<TodoFormCubit>().saveTodo();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
