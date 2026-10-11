import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/app_colors.dart';
import 'package:firebase_task_manager/models/task_priority.dart';

extension TaskPriorityStyle on TaskPriority {
  Color get color => switch (this) {
        TaskPriority.low => AppColors.low,
        TaskPriority.medium => AppColors.medium,
        TaskPriority.high => AppColors.high,
      };

  Color get background => switch (this) {
        TaskPriority.low => AppColors.lowBg,
        TaskPriority.medium => AppColors.mediumBg,
        TaskPriority.high => AppColors.highBg,
      };
}
