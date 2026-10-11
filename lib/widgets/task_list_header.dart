import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_task_manager/core/app_colors.dart';
import 'package:firebase_task_manager/core/date_formatter.dart';
import 'package:firebase_task_manager/core/safe_call.dart';
import 'package:firebase_task_manager/models/task_sort.dart';
import 'package:firebase_task_manager/providers/service_providers.dart';
import 'package:firebase_task_manager/providers/task_providers.dart';

/// Title + total badge, search, sort menu and logout.
class TaskListHeader extends ConsumerStatefulWidget {
  const TaskListHeader({super.key});

  @override
  ConsumerState<TaskListHeader> createState() => _TaskListHeaderState();
}

class _TaskListHeaderState extends ConsumerState<TaskListHeader> {
  bool _searching = false;

  void _closeSearch() {
    ref.read(taskSearchProvider.notifier).state = '';
    setState(() => _searching = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 8, 12),
      child: _searching ? _searchRow() : _titleRow(),
    );
  }

  Widget _searchRow() => Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              onChanged: (v) => ref.read(taskSearchProvider.notifier).state = v,
              decoration: const InputDecoration(
                hintText: 'Search tasks...',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, size: 20),
              ),
            ),
          ),
          IconButton(onPressed: _closeSearch, icon: const Icon(Icons.close)),
        ],
      );

  Widget _titleRow() {
    final total = ref.watch(tasksStreamProvider).valueOrNull?.length ?? 0;
    final sort = ref.watch(taskSortProvider);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Tasks',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E7FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('$total TOTAL',
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary)),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(DateFormatter.todayHeader(DateTime.now()),
                  style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary)),
            ],
          ),
        ),
        IconButton(
          onPressed: () => setState(() => _searching = true),
          icon: const Icon(Icons.search, size: 22),
        ),
        PopupMenuButton<TaskSort>(
          icon: const Icon(Icons.tune, size: 22),
          tooltip: 'Sort',
          onSelected: (s) => ref.read(taskSortProvider.notifier).state = s,
          itemBuilder: (_) => [
            for (final s in TaskSort.values)
              PopupMenuItem(
                value: s,
                child: Row(
                  children: [
                    Icon(s == sort ? Icons.check : null, size: 16),
                    const SizedBox(width: 8),
                    Text(s.label),
                  ],
                ),
              ),
          ],
        ),
        IconButton(
          onPressed: () => runSafely(context, ref.read(authServiceProvider).signOut),
          tooltip: 'Sign out',
          icon: const Icon(Icons.logout, size: 20),
        ),
      ],
    );
  }
}
