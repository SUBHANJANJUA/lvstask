import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5.h),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(fontSize: 19.sp, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 19.sp),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.fieldFill,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 22.w,
              vertical: 22.h,
            ),
          ),
        ),
      ],
    );
  }
}
