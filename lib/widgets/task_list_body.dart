import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_task_manager/core/app_exception.dart';
import 'package:firebase_task_manager/core/safe_call.dart';
import 'package:firebase_task_manager/models/task_model.dart';
import 'package:firebase_task_manager/providers/service_providers.dart';
import 'package:firebase_task_manager/providers/task_providers.dart';
import 'package:firebase_task_manager/screens/task_form_screen.dart';
import 'package:firebase_task_manager/widgets/delete_task_dialog.dart';
import 'package:firebase_task_manager/widgets/empty_tasks_view.dart';
import 'package:firebase_task_manager/widgets/task_card.dart';

/// The scrolling list
class TaskListBody extends ConsumerWidget {
  const TaskListBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksStreamProvider);
    final visible = ref.watch(visibleTasksProvider);

    return tasksAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(errorMessage(error)),
            TextButton(
              onPressed: () => ref.invalidate(tasksStreamProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (all) {
        if (visible.isEmpty) return EmptyTasksView(isFiltering: all.isNotEmpty);
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
          itemCount: visible.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) {
            final task = visible[i];
            return TaskCard(
              key: ValueKey(task.id),
              task: task,
              onToggle: () => _toggle(context, ref, task),
              onEdit: () => TaskFormScreen.open(context, task: task),
              onDelete: () => _delete(context, ref, task),
            );
          },
        );
      },
    );
  }

  Future<void> _toggle(BuildContext context, WidgetRef ref, TaskModel task) {
    final service = ref.read(taskServiceProvider);
    return runSafely(
      context,
      () => service.setCompleted(task.id, completed: !task.isCompleted),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, TaskModel task) async {
    final service = ref.read(taskServiceProvider);
    final confirmed = await showDeleteTaskDialog(context, task);
    if (confirmed != true || !context.mounted) return;
    await runSafely(context, () => service.deleteTask(task.id));
  }
}
