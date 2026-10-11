import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/app_colors.dart';
import 'package:firebase_task_manager/core/date_formatter.dart';
import 'package:firebase_task_manager/models/task_model.dart';
import 'package:firebase_task_manager/widgets/priority_tag.dart';


Future<bool?> showDeleteTaskDialog(BuildContext context, TaskModel task) =>
    showDialog<bool>(
      context: context,
      barrierColor: const Color(0x99000000),
      builder: (_) => DeleteTaskDialog(task: task),
    );

class DeleteTaskDialog extends StatelessWidget {
  const DeleteTaskDialog({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(color: AppColors.highBg, shape: BoxShape.circle),
              child: const Icon(Icons.delete_outline, color: AppColors.high),
            ),
            const SizedBox(height: 14),
            const Text('Delete Task?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            const Text(
              'Are you sure you want to remove this task?\nThis action cannot be undone.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
            ),
            const SizedBox(height: 16),
            _Preview(task: task),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: () => Navigator.of(context).pop(true),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.high,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('Delete Task',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel',
                  style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview({required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (task.bucket != null)
                Text(task.bucket!,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.primary)),
              const Spacer(),
              PriorityTag(priority: task.priority, suffix: ' Priority'),
            ],
          ),
          const SizedBox(height: 6),
          Text(task.title,
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.textMuted),
              const SizedBox(width: 5),
              Text('Due ${DateFormatter.full(task.dueDate)}',
                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}
