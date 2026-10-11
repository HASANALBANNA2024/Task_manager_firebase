import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_task_manager/app.dart';
import 'package:firebase_task_manager/providers/service_providers.dart';
import 'package:firebase_task_manager/services/fcm_background_handler.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// all task topics subscriptions
  await FirebaseMessaging.instance.subscribeToTopic('all_tasks');

  /// background and terminated state handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  /// foreground app state handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint("Foreground notification received: ${message.notification?.title}");
  });

  /// fcm token print logic
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("==================================================");
    debugPrint("fcm token: $token");
    debugPrint("==================================================");
  } catch (e) {
    debugPrint("fcm token: $e");
  }

  /// local notifications service initialization
  final container = ProviderContainer();
  await container.read(localNotificationServiceProvider).init();

  runApp(UncontrolledProviderScope(
    container: container,
    child: const TaskManagerApp(),
  ));
}