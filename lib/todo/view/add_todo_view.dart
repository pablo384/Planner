import 'dart:developer';

import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('To go back'),
        centerTitle: false,
      ),
      body: const SafeArea(
        child: TodoFormWidget(),
      ),
    );
  }
}

class TodoFormWidget extends StatefulWidget {
  const TodoFormWidget({
    super.key,
  });

  @override
  State<TodoFormWidget> createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<TodoFormWidget> {
  final TextEditingController _textTitleController = TextEditingController();
  final TextEditingController _textCategoryController = TextEditingController();
  final TextEditingController _textDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _textTitleController.dispose();
    _textCategoryController.dispose();
    _textDateController.dispose();
    super.dispose();
  }

  String? validator(String? val) {
    if (val == null || val.isEmpty) return 'This field is required';
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
                // errorText: state.username.invalid ? 'invalid username' : null,
              ),
              validator: validator,
            ),
            TextFormField(
              validator: validator,
              decoration: const InputDecoration(
                labelText: 'Category',
                // errorText: state.username.invalid ? 'invalid username' : null,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.datetime,
              validator: validator,
              decoration: InputDecoration(
                labelText: 'When',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month_outlined),
                  onPressed: () {},
                ),
                // errorText: state.username.invalid ? 'invalid username' : null,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log('Valid Form');
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
