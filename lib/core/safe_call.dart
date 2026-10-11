import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/app_exception.dart';
import 'package:firebase_task_manager/core/snackbar.dart';

/// Show snackbar
Future<bool> runSafely(BuildContext context, Future<void> Function() action) async {
  try {
    await action();
    return true;
  } catch (e) {
    if (context.mounted) showSnack(context, errorMessage(e));
    return false;
  }
}
