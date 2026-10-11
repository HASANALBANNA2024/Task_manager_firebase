import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/app_colors.dart';
import 'package:firebase_task_manager/core/date_formatter.dart';
import 'package:firebase_task_manager/models/task_model.dart';
import 'package:firebase_task_manager/widgets/priority_tag.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  final TaskModel task;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final done = task.isCompleted;
    return Opacity(
      opacity: done ? 0.55 : 1,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CheckCircle(done: done, onTap: onToggle),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PriorityTag(priority: task.priority),
                      if (done) ...[const SizedBox(width: 6), const _DoneTag()],
                      const Spacer(),
                      _IconAction(icon: Icons.edit_outlined, onTap: onEdit),
                      const SizedBox(width: 12),
                      _IconAction(icon: Icons.delete_outline, onTap: onDelete),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      decoration: done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (task.description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(task.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ],
                  const SizedBox(height: 10),
                  const Divider(height: 1, color: AppColors.border),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(done ? Icons.check_circle_outline : Icons.calendar_today_outlined,
                          size: 13, color: AppColors.textMuted),
                      const SizedBox(width: 5),
                      Text('Due ${DateFormatter.short(task.dueDate)}',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: task.isOverdue ? AppColors.high : AppColors.textSecondary)),
                      const SizedBox(width: 14),
                      const Icon(Icons.access_time, size: 13, color: AppColors.textMuted),
                      const SizedBox(width: 5),
                      Text(DateFormatter.short(task.createdAt),
                          style: const TextStyle(
                              fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckCircle extends StatelessWidget {
  const _CheckCircle({required this.done, required this.onTap});
  final bool done;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        margin: const EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: done ? AppColors.textSecondary : Colors.transparent,
          border: Border.all(color: done ? AppColors.textSecondary : AppColors.textMuted, width: 1.5),
        ),
        child: done ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
      ),
    );
  }
}

class _DoneTag extends StatelessWidget {
  const _DoneTag();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: AppColors.lowBg,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text('Done',
            style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: AppColors.low)),
      );
}

class _IconAction extends StatelessWidget {
  const _IconAction({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Icon(icon, size: 17, color: AppColors.textMuted),
      );
}
