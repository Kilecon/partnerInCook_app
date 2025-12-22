import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

void showSnackWarning(String message) {
  // Implémentez votre logique d'affichage d'avertissement ici
  // Par exemple avec Get.snackbar ou votre méthode préférée
  Get.snackbar(
    'Attention',
    message,
    backgroundColor: AppColors.lightOrange,
    duration: const Duration(seconds: 2),
    icon: const Icon(Icons.warning),
  );
}

void showSnackError(String message) {
  // Implémentez votre logique d'affichage d'erreur ici
  // Par exemple avec Get.snackbar ou votre méthode préférée
  Get.snackbar(
    'Erreur',
    message,
    backgroundColor: AppColors.lightOrange,
    icon: const Icon(Icons.error),
    duration: const Duration(seconds: 2),
  );
}

void showSnackInfo(String message) {
  // Implémentez votre logique d'affichage d'information ici
  // Par exemple avec Get.snackbar ou votre méthode préférée
  Get.snackbar(
    'Information',
    message,
    backgroundColor: AppColors.lightOrange,
    icon: const Icon(Icons.info),
    duration: const Duration(seconds: 2),
  );
}
