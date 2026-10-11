import 'package:firebase_task_manager/models/task_model.dart';

enum TaskFilter {
  all('All'),
  pending('Pending'),
  completed('Completed');

  const TaskFilter(this.label);
  final String label;

  bool matches(TaskModel task) => switch (this) {
        TaskFilter.all => true,
        TaskFilter.pending => !task.isCompleted,
        TaskFilter.completed => task.isCompleted,
      };
}
