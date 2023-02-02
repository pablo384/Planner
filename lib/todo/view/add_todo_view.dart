import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

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
        title: const Text("To go back"),
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

  @override
  void dispose() {
    _textTitleController.dispose();
    _textCategoryController.dispose();
    _textDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Form"),
    );
  }
}
