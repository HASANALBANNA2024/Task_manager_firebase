import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/app_colors.dart';
import 'package:firebase_task_manager/core/app_theme.dart';
import 'package:firebase_task_manager/models/task_buckets.dart';
import 'package:firebase_task_manager/widgets/section_label.dart';

class BucketDropdown extends StatelessWidget {
  const BucketDropdown({super.key, required this.value, required this.onChanged});
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final items = {...TaskBuckets.all, if (value != null) value!}.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Course bucket'),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          hint: const Text('Select', style: TextStyle(fontSize: 13)),
          items: [for (final b in items) DropdownMenuItem(value: b, child: Text(b))],
          onChanged: onChanged,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: AppTheme.inputBorder(),
            enabledBorder: AppTheme.inputBorder(),
          ),
        ),
      ],
    );
  }
}
