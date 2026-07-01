import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 56,
    this.backgroundColor = AppColors.fieldFill,
    this.iconColor = AppColors.textMuted,
    this.badge,
    this.hasGradient = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final String? badge;
  final bool hasGradient;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Ink(
              width: size.w,
              height: size.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hasGradient ? null : backgroundColor,
                gradient: hasGradient ? AppColors.primaryGradient : null,
                boxShadow: hasGradient
                    ? [
                        BoxShadow(
                          color: AppColors.lime.withValues(alpha: .28),
                          blurRadius: 22,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : null,
              ),
              child: Icon(icon, color: iconColor, size: 28.sp),
            ),
          ),
        ),
        if (badge != null)
          Positioned(
            top: -2.h,
            right: -2.w,
            child: Container(
              width: 24.w,
              height: 24.w,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.danger,
                shape: BoxShape.circle,
              ),
              child: Text(
                badge!,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
