import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

void showWarning(String message) {
    // Implémentez votre logique d'affichage d'avertissement ici
    // Par exemple avec Get.snackbar ou votre méthode préférée
    Get.snackbar(
      'Attention',
      message,
      backgroundColor: AppColors.warningColorLight,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.warning),
    );
  }

void showError(String message) {
    // Implémentez votre logique d'affichage d'erreur ici
    // Par exemple avec Get.snackbar ou votre méthode préférée
    Get.snackbar(
      'Erreur',
      message,
      backgroundColor: AppColors.errorColorLight,
      icon: const Icon(Icons.error),
      duration: const Duration(seconds: 2),
    );
  }


  void showInfo(String message) {
    // Implémentez votre logique d'affichage d'information ici
    // Par exemple avec Get.snackbar ou votre méthode préférée
    Get.snackbar(
      'Information',
      message,
      backgroundColor: AppColors.infoColorLight,
      icon: const Icon(Icons.info),
      duration: const Duration(seconds: 2),
    );
  }