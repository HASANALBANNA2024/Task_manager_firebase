import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_task_manager/models/task_priority.dart';
import 'package:firebase_task_manager/services/fcm_token_service.dart';
import 'package:firebase_task_manager/services/local_notification_service.dart';
import 'package:firebase_task_manager/services/notification_router.dart';

/// Firebase Cloud Messaging
class FcmService {
  FcmService(this._messaging, this._tokens, this._local, this._router);

  final FirebaseMessaging _messaging;
  final FcmTokenService _tokens;
  final LocalNotificationService _local;
  final NotificationRouter _router;

  final List<StreamSubscription<Object?>> _subscriptions = [];
  bool _started = false;

  Future<void> start() async {
    if (_started) return;
    _started = true;

    try {
      await _messaging.requestPermission(alert: true, badge: true, sound: true);

      final token = await _messaging.getToken();
      debugPrint('FCM token: $token');
      if (token != null) await _tokens.save(token);

      _subscriptions
        ..add(_messaging.onTokenRefresh.listen(_tokens.save))
        ..add(FirebaseMessaging.onMessage.listen(_onForegroundMessage))
        ..add(FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpened))
        ..add(_local.taps.listen(_router.request));

      final initial = await _messaging.getInitialMessage();
      if (initial != null) _onMessageOpened(initial);
    } catch (e) {
      debugPrint('FCM setup failed: $e');
    }
  }

  Future<void> stop() async {
    for (final s in _subscriptions) {
      await s.cancel();
    }
    _subscriptions.clear();
    _router.reset();
    _started = false;
  }

  /// App is open show local notifications
  void _onForegroundMessage(RemoteMessage message) {
    _local.show(
      title: message.notification?.title ?? message.data['title']?.toString() ?? 'Task Manager',
      body: message.notification?.body ?? message.data['body']?.toString() ?? '',
      taskId: message.data['taskId']?.toString(),
      priority: TaskPriority.fromName(message.data['priority']?.toString()),
    );
  }

  void _onMessageOpened(RemoteMessage message) {
    final taskId = message.data['taskId']?.toString();
    if (taskId != null && taskId.isNotEmpty) _router.request(taskId);
  }
}
