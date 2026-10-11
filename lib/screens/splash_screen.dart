import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/app_colors.dart';
import 'package:firebase_task_manager/widgets/app_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF1F5FF), Colors.white],
          ),
        ),
        child: const SafeArea(
          child: Column(
            children: [
              Spacer(flex: 3),
              AppLogo(size: 84),
              SizedBox(height: 28),
              Text('Firebase Task Manager',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
              SizedBox(height: 8),
              Text(
                'A simple task manager powered by Flutter\n& Firestore',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.5, color: AppColors.textSecondary, height: 1.4),
              ),
              Spacer(flex: 3),
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
              ),
              SizedBox(height: 10),
              Text('Initializing app...',
                  style: TextStyle(fontSize: 11.5, color: AppColors.textMuted)),
              SizedBox(height: 24),
              Text('FLUTTER • FIREBASE',
                  style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted)),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
