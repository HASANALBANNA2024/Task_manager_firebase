import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/app_colors.dart';
import 'package:firebase_task_manager/models/task_priority.dart';
import 'package:firebase_task_manager/widgets/priority_style.dart';

class PrioritySelector extends StatelessWidget {
  const PrioritySelector({super.key, required this.value, required this.onChanged});
  final TaskPriority value;
  final ValueChanged<TaskPriority> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final p in TaskPriority.values) ...[
          Expanded(child: _Option(priority: p, selected: p == value, onTap: () => onChanged(p))),
          if (p != TaskPriority.values.last) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({required this.priority, required this.selected, required this.onTap});
  final TaskPriority priority;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: selected ? priority.background : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? priority.color : AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: priority.color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(priority.label,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }
}
