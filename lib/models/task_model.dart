import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_task_manager/models/task_priority.dart';

/// Task model
class TaskModel {
  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.isCompleted,
    required this.createdAt,
    this.bucket,
  });

  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskPriority priority;
  final bool isCompleted;
  final DateTime createdAt;
  final String? bucket;

  bool get isOverdue {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return !isCompleted && dueDate.isBefore(today);
  }

  factory TaskModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? const <String, dynamic>{};
    return TaskModel(
      id: doc.id,
      title: d['title'] as String? ?? '',
      description: d['description'] as String? ?? '',
      dueDate: (d['dueDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      priority: TaskPriority.fromName(d['priority'] as String?),
      isCompleted: d['isCompleted'] as bool? ?? false,
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      bucket: d['bucket'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'dueDate': Timestamp.fromDate(dueDate),
        'priority': priority.name,
        'isCompleted': isCompleted,
        'createdAt': Timestamp.fromDate(createdAt),
        'bucket': bucket,
      };

  TaskModel copyWith({String? id}) => TaskModel(
        id: id ?? this.id,
        title: title,
        description: description,
        dueDate: dueDate,
        priority: priority,
        isCompleted: isCompleted,
        createdAt: createdAt,
        bucket: bucket,
      );
}
