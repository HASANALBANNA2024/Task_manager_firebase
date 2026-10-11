import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/app_colors.dart';
import 'package:firebase_task_manager/core/date_formatter.dart';
import 'package:firebase_task_manager/widgets/section_label.dart';

/// Tap to open the date picker.
class DueDateField extends StatelessWidget {
  const DueDateField({super.key, required this.date, required this.onTap});
  final DateTime date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Due date'),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 15, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(DateFormatter.numeric(date),
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
