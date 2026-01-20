import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

void showSnackError(String message) {
  _showSnack(message, 'Erreur', Icons.error, AppColors.lightOrange);
}

void showSnackWarning(String message) {
  _showSnack(message, 'Attention', Icons.warning, AppColors.lightOrange);
}

void showSnackInfo(String message) {
  _showSnack(message, 'Information', Icons.info, AppColors.lightOrange);
}

/// Private helper to wrap snackbar in post-frame callback
void _showSnack(String message, String title, IconData icon, Color bgColor) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // Ensure GetMaterialApp exists!
    if (Get.isRegistered<GetMaterialApp>() || Get.context != null) {
      Get.snackbar(
        title,
        message,
        backgroundColor: bgColor,
        icon: Icon(icon, color: Colors.white),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      // Optional: fallback, print if snackbar cannot be shown
      debugPrint('Snackbar not shown: $title - $message');
    }
  });
}
