import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF111111);
  static const Color textPrimary = Color(0xFF171717);
  static const Color textMuted = Color(0xFF8F8F8F);
  static const Color fieldFill = Color(0xFFF2F2F2);
  static const Color divider = Color(0xFFE9E9E9);
  static const Color lime = Color(0xFFD9FF00);
  static const Color green = Color(0xFF00A927);
  static const Color brightGreen = Color(0xFF50C900);
  static const Color danger = Color(0xFFFF1212);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [lime, green],
  );
}
