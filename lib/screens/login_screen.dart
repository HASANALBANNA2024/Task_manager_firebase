import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_task_manager/core/app_colors.dart';
import 'package:firebase_task_manager/core/safe_call.dart';
import 'package:firebase_task_manager/core/snackbar.dart';
import 'package:firebase_task_manager/core/validators.dart';
import 'package:firebase_task_manager/providers/service_providers.dart';
import 'package:firebase_task_manager/screens/sign_up_screen.dart';
import 'package:firebase_task_manager/widgets/app_logo.dart';
import 'package:firebase_task_manager/widgets/app_text_field.dart';
import 'package:firebase_task_manager/widgets/google_button.dart';
import 'package:firebase_task_manager/widgets/or_divider.dart';
import 'package:firebase_task_manager/widgets/password_field.dart';
import 'package:firebase_task_manager/widgets/primary_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  /// loading spinner or error snackbar
  Future<void> _run(Future<void> Function() action) async {
    setState(() => _loading = true);
    await runSafely(context, action);
    if (mounted) setState(() => _loading = false);
  }

  void _signIn() {
    if (!_formKey.currentState!.validate()) return;
    _run(() => ref.read(authServiceProvider).signIn(_email.text, _password.text));
  }

  void _google() => _run(ref.read(authServiceProvider).signInWithGoogle);

  void _forgotPassword() {
    if (Validators.email(_email.text) != null) {
      showSnack(context, 'Enter your email first.');
      return;
    }
    _run(() async {
      await ref.read(authServiceProvider).sendPasswordReset(_email.text);
      if (mounted) showSnack(context, 'Password reset email sent.');
    });
  }

  void _openSignUp() => Navigator.of(context)
      .push(MaterialPageRoute<void>(builder: (_) => const SignUpScreen()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const AppLogo(size: 64),
                  const SizedBox(height: 20),
                  const Text('Welcome Back',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  const Text('Sign in to your Firebase Task Manager',
                      style: TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
                  const SizedBox(height: 28),
                  AppTextField(
                    label: 'Email address',
                    controller: _email,
                    hint: 'you@example.com',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 16),
                  PasswordField(controller: _password, onForgotPassword: _forgotPassword),
                  const SizedBox(height: 22),
                  PrimaryButton(
                    label: 'Sign In',
                    icon: Icons.arrow_forward,
                    isLoading: _loading,
                    onPressed: _signIn,
                  ),
                  const SizedBox(height: 20),
                  const OrDivider(),
                  const SizedBox(height: 20),
                  GoogleButton(onPressed: _loading ? null : _google),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? ",
                          style: TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
                      GestureDetector(
                        onTap: _openSignUp,
                        child: const Text('Sign Up',
                            style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Flutter • Firebase Auth',
                      style: TextStyle(fontSize: 10.5, color: AppColors.textMuted)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
