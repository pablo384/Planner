import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.date,
    required this.completedCount,
    required this.incompleteCount,
  });

  final DateTime date;
  final int completedCount;
  final int incompleteCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime
                            .now(), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          DateFormat.yMMMMd().format(date),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '$incompleteCount incomplete, $completedCount completed',
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/avatar.webp'),
              )
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
