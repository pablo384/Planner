import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Checkbox(value: false, onChanged: (bool? val) => {}),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload 1099-R to TurboTax",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "💰 Finance",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black45),
              ),
            ],
          )
        ],
      ),
    );
  }
}
