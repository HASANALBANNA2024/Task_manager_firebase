import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_task_manager/providers/service_providers.dart';

/// current user null then logout
final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(authServiceProvider).authStateChanges(),
);

/// splash screen visible time
final splashDelayProvider = FutureProvider<void>(
  (ref) => Future<void>.delayed(const Duration(milliseconds: 1500)),
);
