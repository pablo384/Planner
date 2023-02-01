import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/header_widget.dart';
import '../widgets/todo_section_widget.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.yMMMMd().format(DateTime.now());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                HeaderWidget(date: date),
                const TodoSectionWidget(
                  title: "Incomplete",
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
