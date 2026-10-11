import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_task_manager/core/navigator_key.dart';
import 'package:firebase_task_manager/providers/auth_providers.dart';
import 'package:firebase_task_manager/providers/service_providers.dart';
import 'package:firebase_task_manager/providers/task_providers.dart';


class SessionListener extends ConsumerWidget {
  const SessionListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(authStateProvider, (previous, next) {
      if (next.isLoading) return;
      navigatorKey.currentState?.popUntil((route) => route.isFirst);

      final fcm = ref.read(fcmServiceProvider);
      if (next.valueOrNull != null) {
        fcm.start();
      } else {
        fcm.stop();
        ref.invalidate(taskFilterProvider);
        ref.invalidate(taskSearchProvider);
        ref.invalidate(taskSortProvider);
      }
    });
    return child;
  }
}
