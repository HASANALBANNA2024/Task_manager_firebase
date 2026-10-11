import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_task_manager/core/app_colors.dart';
import 'package:firebase_task_manager/screens/task_form_screen.dart';
import 'package:firebase_task_manager/widgets/task_filter_tabs.dart';
import 'package:firebase_task_manager/widgets/task_list_body.dart';
import 'package:firebase_task_manager/widgets/task_list_header.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Column(
          children: [
            TaskListHeader(),
            TaskFilterTabs(),
            SizedBox(height: 8),
            Expanded(child: TaskListBody()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => TaskFormScreen.open(context),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('New Task', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}