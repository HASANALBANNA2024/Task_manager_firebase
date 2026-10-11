import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_task_manager/providers/firebase_providers.dart';
import 'package:firebase_task_manager/services/auth_service.dart';
import 'package:firebase_task_manager/services/fcm_service.dart';
import 'package:firebase_task_manager/services/fcm_token_service.dart';
import 'package:firebase_task_manager/services/local_notification_service.dart';
import 'package:firebase_task_manager/services/notification_router.dart';
import 'package:firebase_task_manager/services/task_service.dart';
/// authentications provider
final authServiceProvider = Provider(
  (ref) => AuthService(ref.watch(firebaseAuthProvider), ref.watch(googleSignInProvider)),
);

final taskServiceProvider = Provider(
  (ref) => TaskService(ref.watch(firestoreProvider), ref.watch(firebaseAuthProvider)),
);

final localNotificationServiceProvider = Provider(
  (ref) => LocalNotificationService(ref.watch(notificationsPluginProvider)),
);

final fcmTokenServiceProvider = Provider(
  (ref) => FcmTokenService(ref.watch(firestoreProvider), ref.watch(firebaseAuthProvider)),
);

final notificationRouterProvider =
    Provider((ref) => NotificationRouter(ref.watch(taskServiceProvider)));

final fcmServiceProvider = Provider(
  (ref) => FcmService(
    ref.watch(messagingProvider),
    ref.watch(fcmTokenServiceProvider),
    ref.watch(localNotificationServiceProvider),
    ref.watch(notificationRouterProvider),
  ),
);
