import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/app_colors.dart';

class EmptyTasksView extends StatelessWidget {
  const EmptyTasksView({super.key, required this.isFiltering});
  final bool isFiltering;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.task_alt, size: 48, color: AppColors.textMuted),
          const SizedBox(height: 12),
          Text(isFiltering ? 'No matching tasks' : 'No tasks yet',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(isFiltering ? 'Try a different filter or search.' : 'Tap "New Task" to add one.',
              style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
