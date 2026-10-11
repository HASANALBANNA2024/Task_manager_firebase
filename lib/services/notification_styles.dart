import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_task_manager/models/task_priority.dart';

class _Style {
  const _Style(this.id, this.name, this.importance, this.priority);
  final String id;
  final String name;
  final Importance importance;
  final Priority priority;
}

/// Notifications priority.
abstract final class NotificationStyles {
  static const _styles = <TaskPriority, _Style>{
    TaskPriority.high: _Style('task_high', 'High priority tasks', Importance.max, Priority.max),
    TaskPriority.medium: _Style('task_medium', 'Medium priority tasks', Importance.high, Priority.high),
    TaskPriority.low: _Style('task_low', 'Low priority tasks', Importance.low, Priority.low),
  };

  static List<AndroidNotificationChannel> get channels => [
        for (final s in _styles.values)
          AndroidNotificationChannel(s.id, s.name, importance: s.importance),
      ];

  static NotificationDetails detailsFor(TaskPriority priority) {
    final s = _styles[priority]!;
    return NotificationDetails(
      android: AndroidNotificationDetails(
        s.id,
        s.name,
        importance: s.importance,
        priority: s.priority,
      ),
      iOS: const DarwinNotificationDetails(presentAlert: true, presentSound: true),
    );
  }
}
