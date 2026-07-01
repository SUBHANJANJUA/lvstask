import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isGoogleLoading = false.obs;
  final AuthService _authService = Get.find<AuthService>();

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void login() {
    Get.offNamed(Routes.HOME);
  }

  Future<void> signInWithGoogle() async {
    if (isGoogleLoading.value) return;

    try {
      isGoogleLoading.value = true;
      await _authService.signInWithGoogle();
      Get.offNamed(Routes.HOME);
    } on FirebaseAuthException catch (error) {
      _showAuthError(error.message ?? 'Firebase authentication failed.');
    } on GoogleSignInException catch (error) {
      final message = error.code == GoogleSignInExceptionCode.canceled
          ? 'Google sign-in was cancelled or Firebase OAuth is not configured for this Android app SHA.'
          : error.description ?? 'Google sign-in failed.';
      _showAuthError(message);
    } on UnsupportedError catch (error) {
      _showAuthError(error.message ?? 'Google sign-in is not supported.');
    } catch (_) {
      _showAuthError('Unable to sign in with Google. Please try again.');
    } finally {
      isGoogleLoading.value = false;
    }
  }

  void _showAuthError(String message) {
    Get.snackbar(
      'Sign in failed',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void onClose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
