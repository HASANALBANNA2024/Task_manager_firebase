import 'package:flutter/material.dart';
import 'package:firebase_task_manager/core/app_colors.dart';

/// flutter logo (splash and login)
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 76});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + 8,
      height: size + 8,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(size * 0.26),
              boxShadow: const [
                BoxShadow(color: AppColors.shadow, blurRadius: 18, offset: Offset(0, 6)),
              ],
            ),
            child: Center(child: FlutterLogo(size: size * 0.46)),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.32,
              height: size * 0.32,
              decoration: BoxDecoration(
                color: AppColors.badgeOrange,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 2),
              ),
              child: Icon(Icons.local_fire_department,
                  size: size * 0.18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
