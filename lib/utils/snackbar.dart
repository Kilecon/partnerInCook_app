import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

void showSnackError(String message) {
  _showSnack('Erreur', message, Icons.error, AppColors.lightRed, Colors.black, Colors.red);
}

void showSnackWarning(String message) {
  _showSnack('Attention', message, Icons.warning, AppColors.lightOrange, Colors.black, Colors.orange);
}

void showSnackInfo(String message) {
  _showSnack('Information', message, Icons.info, AppColors.lightOrange, Colors.black, Colors.orange);
}

/// Private helper to wrap snackbar in post-frame callback
void _showSnack(
  String title,
  String message,
  IconData icon,
  Color bgColor,
  Color textColor,
  Color borderColor,
) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // Ensure GetMaterialApp exists!
    if (Get.isRegistered<GetMaterialApp>() || Get.context != null) {
      Get.snackbar(
        title,
        message,
        borderWidth: 1,
        borderColor: borderColor,
        backgroundColor: bgColor,
        icon: Icon(icon, color: Colors.white),
        colorText: textColor,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );
    } else {
      // Optional: fallback, print if snackbar cannot be shown
      debugPrint('Snackbar not shown: $title - $message');
    }
  });
}
