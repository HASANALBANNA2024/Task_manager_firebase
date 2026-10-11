import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_task_manager/core/app_colors.dart';
import 'package:firebase_task_manager/core/safe_call.dart';
import 'package:firebase_task_manager/core/validators.dart';
import 'package:firebase_task_manager/models/task_model.dart';
import 'package:firebase_task_manager/models/task_priority.dart';
import 'package:firebase_task_manager/providers/service_providers.dart';
import 'package:firebase_task_manager/widgets/app_text_field.dart';
import 'package:firebase_task_manager/widgets/bucket_dropdown.dart';
import 'package:firebase_task_manager/widgets/completed_switch.dart';
import 'package:firebase_task_manager/widgets/due_date_field.dart';
import 'package:firebase_task_manager/widgets/primary_button.dart';
import 'package:firebase_task_manager/widgets/priority_selector.dart';
import 'package:firebase_task_manager/widgets/section_label.dart';

///  new  task screen and edit screen
class TaskFormScreen extends ConsumerStatefulWidget {
  const TaskFormScreen({super.key, this.task});
  final TaskModel? task;

  static Future<void> open(BuildContext context, {TaskModel? task}) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => TaskFormScreen(task: task)),
      );

  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
  static const _maxTitle = 66;

  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  late DateTime _dueDate;
  late TaskPriority _priority;
  late bool _completed;
  String? _bucket;
  bool _saving = false;

  bool get _isEdit => widget.task != null;

  @override
  void initState() {
    super.initState();
    _fill(widget.task);
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }


  void _fill(TaskModel? t) {
    _title.text = t?.title ?? '';
    _description.text = t?.description ?? '';
    _dueDate = t?.dueDate ?? DateTime.now();
    _priority = t?.priority ?? TaskPriority.medium;
    _completed = t?.isCompleted ?? false;
    _bucket = t?.bucket;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final floor = DateTime(now.year - 1);
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: _dueDate.isBefore(floor) ? _dueDate : floor,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final tasks = ref.read(taskServiceProvider);
    final notifications = ref.read(localNotificationServiceProvider);
    final old = widget.task;
    final task = TaskModel(
      id: old?.id ?? '',
      title: _title.text.trim(),
      description: _description.text.trim(),
      dueDate: _dueDate,
      priority: _priority,
      isCompleted: _completed,
      createdAt: old?.createdAt ?? DateTime.now(),
      bucket: _bucket,
    );

    setState(() => _saving = true);
    final ok = await runSafely(context, () async {
      if (_isEdit) {
        await tasks.updateTask(task);
      } else {
        final created = await tasks.addTask(task);
        await notifications.showTaskCreated(created); // "New Task" notification
      }
    });

    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop();
    } else {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(_isEdit ? 'Edit Task' : 'New Task'),
        actions: [
          if (_isEdit)
            TextButton(
              onPressed: () => setState(() => _fill(widget.task)),
              child: const Text('Reset',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            children: [
              AppTextField(
                label: 'Task title',
                controller: _title,
                hint: 'e.g. Complete Flutter Assignment',
                maxLength: _maxTitle,
                textInputAction: TextInputAction.next,
                validator: (v) => Validators.notEmpty(v, 'Title'),
                trailingLabel: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _title,
                  builder: (_, value, __) => Text('${value.text.length}/$_maxTitle',
                      style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted)),
                ),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Description & notes',
                controller: _description,
                hint: 'Add details, links, or notes...',
                minLines: 3,
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: DueDateField(date: _dueDate, onTap: _pickDate)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: BucketDropdown(
                      value: _bucket,
                      onChanged: (v) => setState(() => _bucket = v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const SectionLabel('Priority'),
              const SizedBox(height: 6),
              PrioritySelector(
                value: _priority,
                onChanged: (p) => setState(() => _priority = p),
              ),
              if (_isEdit) ...[
                const SizedBox(height: 16),
                CompletedSwitch(
                  value: _completed,
                  onChanged: (v) => setState(() => _completed = v),
                ),
              ],
              const SizedBox(height: 28),
              PrimaryButton(
                label: _isEdit ? 'Save Changes' : 'Save Task',
                icon: _isEdit ? Icons.check : null,
                color: _isEdit ? AppColors.navy : AppColors.primary,
                isLoading: _saving,
                onPressed: _save,
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
