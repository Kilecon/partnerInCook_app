import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/logos/logo_w_label.png',
              width: 280,
              height: 280,
            ),
          ),
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: AppColors.primaryOrange),
                const SizedBox(height: 20),
                Text(
                  'V${controller.version}',
                  style: const TextStyle(color: AppColors.lightGray),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
