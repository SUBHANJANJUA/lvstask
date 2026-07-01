import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/social_button.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(22.w, 38.h, 22.w, 0),
                      child: Column(
                        children: [
                          const AppLogo(size: 82),
                          SizedBox(height: 20.h),
                          Text(
                            'Welcome back! 👋',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 31.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'Sign in to continue your live streaming journey.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          AppTextField(
                            label: 'Email ID or Phone Number',
                            hintText: 'Enter Registered Email Or Phone No.',
                            controller: controller.emailOrPhoneController,
                          ),
                          SizedBox(height: 15.h),
                          Obx(
                            () => AppTextField(
                              label: 'Password',
                              hintText: 'Enter your password',
                              controller: controller.passwordController,
                              obscureText: !controller.isPasswordVisible.value,
                              suffixIcon: IconButton(
                                onPressed: controller.togglePasswordVisibility,
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.textMuted,
                                  size: 25.sp,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.green,
                                padding: EdgeInsets.only(top: 12.h),
                              ),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.green,
                                  color: AppColors.green,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          GradientButton(
                            label: 'Login',
                            onTap: controller.login,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    _AuthBottomPanel(controller: controller),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AuthBottomPanel extends StatelessWidget {
  const _AuthBottomPanel({required this.controller});

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Image.asset(
          'assets/images/authbottom.png',
          // width: double.infinity,
          // height: 400.h,
          // fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 65.h),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.white.withValues(alpha: .55),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Text(
                      'or continue with',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.white.withValues(alpha: .55),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Obx(
                () => SocialButton(
                  label: controller.isGoogleLoading.value
                      ? 'Connecting...'
                      : 'Continue with Google',
                  icon: 'assets/images/googleicon.png',
                  iconColor: const Color(0xFF4285F4),
                  onTap: controller.isGoogleLoading.value
                      ? null
                      : controller.signInWithGoogle,
                ),
              ),
              SizedBox(height: 10.h),
              const SocialButton(
                label: 'Continue with Facebook',
                icon: 'assets/images/facebook.png',
                iconColor: Color(0xFF1877F2),
              ),
              SizedBox(height: 10.h),
              Text.rich(
                TextSpan(
                  text: 'Don’t have an account? ',
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
