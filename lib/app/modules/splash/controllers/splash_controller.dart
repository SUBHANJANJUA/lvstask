import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    animationController.forward();

    _navigateToAuth();
  }

  Future<void> _navigateToAuth() async {
    await Future.delayed(const Duration(seconds: 3));

    Get.offNamed('/auth');
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
