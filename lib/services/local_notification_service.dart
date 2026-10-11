import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_task_manager/models/task_model.dart';
import 'package:firebase_task_manager/models/task_priority.dart';
import 'package:firebase_task_manager/services/notification_styles.dart';

/// Shows local notifications
class LocalNotificationService {
  LocalNotificationService(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;
  final _taps = StreamController<String>.broadcast();

  /// user taps local notifications then taskId
  Stream<String> get taps => _taps.stream;

  Future<void> init() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) _taps.add(payload);
      },
    );

    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();
    for (final channel in NotificationStyles.channels) {
      await android?.createNotificationChannel(channel);
    }
  }

  Future<void> show({
    required String title,
    required String body,
    String? taskId,
    TaskPriority priority = TaskPriority.medium,
  }) {
    final id = DateTime.now().millisecondsSinceEpoch.remainder(0x7FFFFFFF);
    return _plugin.show(
      id,
      title,
      body,
      NotificationStyles.detailsFor(priority),
      payload: taskId,
    );
  }

  Future<void> showTaskCreated(TaskModel task) => show(
        title: 'New Task',
        body: 'You have a new task: ${task.title}',
        taskId: task.id,
        priority: task.priority,
      );
}
