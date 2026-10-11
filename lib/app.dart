import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/app_theme.dart';
import 'package:firebase_task_manager/core/navigator_key.dart';
import 'package:firebase_task_manager/screens/auth_gate.dart';
import 'package:firebase_task_manager/widgets/session_listener.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Task Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      navigatorKey: navigatorKey,
      builder: (context, child) => SessionListener(child: child!),
      home: const AuthGate(),
    );
  }
}
