import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_task_manager/providers/auth_providers.dart';
import 'package:firebase_task_manager/screens/login_screen.dart';
import 'package:firebase_task_manager/screens/splash_screen.dart';
import 'package:firebase_task_manager/screens/task_list_screen.dart';

/// select the first screen splash - login or task list.
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splash = ref.watch(splashDelayProvider);
    final auth = ref.watch(authStateProvider);

    if (splash.isLoading || auth.isLoading) return const SplashScreen();
    return auth.valueOrNull == null ? const LoginScreen() : const TaskListScreen();
  }
}
