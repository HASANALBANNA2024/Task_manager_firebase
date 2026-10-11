import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_task_manager/models/task_filter.dart';
import 'package:firebase_task_manager/models/task_model.dart';
import 'package:firebase_task_manager/models/task_sort.dart';
import 'package:firebase_task_manager/providers/auth_providers.dart';
import 'package:firebase_task_manager/providers/service_providers.dart';

/// list from firebase
final tasksStreamProvider = StreamProvider<List<TaskModel>>((ref) {
  final user = ref.watch(authStateProvider).valueOrNull;
  if (user == null) return Stream.value(const <TaskModel>[]);
  return ref.watch(taskServiceProvider).watchTasks();
});

/// filter task
final taskFilterProvider = StateProvider<TaskFilter>((_) => TaskFilter.all);
final taskSearchProvider = StateProvider<String>((_) => '');
final taskSortProvider = StateProvider<TaskSort>((_) => TaskSort.newest);

/// task list after fileter
final visibleTasksProvider = Provider<List<TaskModel>>((ref) {
  final tasks = ref.watch(tasksStreamProvider).valueOrNull ?? const <TaskModel>[];
  final filter = ref.watch(taskFilterProvider);
  final query = ref.watch(taskSearchProvider).trim().toLowerCase();
  final sort = ref.watch(taskSortProvider);

  final filtered = tasks.where((t) =>
      filter.matches(t) &&
      (query.isEmpty ||
          t.title.toLowerCase().contains(query) ||
          t.description.toLowerCase().contains(query)));

  return sort.apply(filtered.toList());
});

/// total task of filter (after filter)
final taskCountsProvider = Provider<Map<TaskFilter, int>>((ref) {
  final tasks = ref.watch(tasksStreamProvider).valueOrNull ?? const <TaskModel>[];
  return {for (final f in TaskFilter.values) f: tasks.where(f.matches).length};
});
