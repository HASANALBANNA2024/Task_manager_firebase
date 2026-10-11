import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/navigator_key.dart';
import 'package:firebase_task_manager/screens/task_form_screen.dart';
import 'package:firebase_task_manager/services/task_service.dart';

/// Notifications routers
class NotificationRouter {
  NotificationRouter(this._taskService);

  final TaskService _taskService;
  String? _pendingTaskId;
  bool _ready = false;

  void request(String taskId) {
    _pendingTaskId = taskId;
    _flush();
  }

  void markReady() {
    _ready = true;
    _flush();
  }

  void reset() => _ready = false;

  Future<void> _flush() async {
    final id = _pendingTaskId;
    if (!_ready || id == null) return;
    _pendingTaskId = null;

    try {
      final task = await _taskService.getTask(id);
      if (task == null) return;
      navigatorKey.currentState?.push(
        MaterialPageRoute<void>(builder: (_) => TaskFormScreen(task: task)),
      );
    } catch (e) {
      debugPrint('Could not open task from notification: $e');
    }
  }
}
