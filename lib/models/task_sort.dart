import 'package:firebase_task_manager/models/task_model.dart';
/// task sorting
enum TaskSort {
  newest('Newest first'),
  dueDate('Due date'),
  priority('Priority');

  const TaskSort(this.label);
  final String label;

  List<TaskModel> apply(List<TaskModel> tasks) {
    final list = [...tasks];
    switch (this) {
      case TaskSort.newest:
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case TaskSort.dueDate:
        list.sort((a, b) => a.dueDate.compareTo(b.dueDate));
      case TaskSort.priority:
        list.sort((a, b) => b.priority.weight.compareTo(a.priority.weight));
    }
    return list;
  }
}
