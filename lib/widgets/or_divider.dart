import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/app_colors.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) => const Row(
        children: [
          Expanded(child: Divider(color: AppColors.border)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('or continue with',
                style: TextStyle(fontSize: 11.5, color: AppColors.textMuted)),
          ),
          Expanded(child: Divider(color: AppColors.border)),
        ],
      );
}
