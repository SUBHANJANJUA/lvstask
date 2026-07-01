import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 86});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Image.asset(
        AppAssets.logo,
        width: size.w,
        height: size.w,
        fit: BoxFit.contain,
      ),
    );
  }
}
