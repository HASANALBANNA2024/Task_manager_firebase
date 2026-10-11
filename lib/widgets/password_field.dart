import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/app_colors.dart';
import 'package:firebase_task_manager/core/validators.dart';
import 'package:firebase_task_manager/widgets/app_text_field.dart';

/// Password field
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.label = 'Password',
    this.validator = Validators.password,
    this.onForgotPassword,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  final VoidCallback? onForgotPassword;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: widget.label,
      controller: widget.controller,
      obscureText: _obscure,
      validator: widget.validator,
      trailingLabel: widget.onForgotPassword == null
          ? null
          : GestureDetector(
              onTap: widget.onForgotPassword,
              child: const Text('Forgot Password?',
                  style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary)),
            ),
      suffixIcon: IconButton(
        icon: Icon(
          _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          size: 20,
          color: AppColors.textMuted,
        ),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
    );
  }
}
