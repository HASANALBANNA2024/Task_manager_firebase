import 'package:flutter/material.dart';
import 'package:firebase_task_manager/models/task_priority.dart';
import 'package:firebase_task_manager/widgets/priority_style.dart';

class PriorityTag extends StatelessWidget {
  const PriorityTag({super.key, required this.priority, this.suffix = ''});
  final TaskPriority priority;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: priority.background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: priority.color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text('${priority.label}$suffix',
              style: TextStyle(
                  fontSize: 10.5, fontWeight: FontWeight.w700, color: priority.color)),
        ],
      ),
    );
  }
}
