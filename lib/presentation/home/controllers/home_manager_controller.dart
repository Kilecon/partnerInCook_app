import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeManagerController extends GetxController {
  var currentPageIndex = 0.obs;

  // Méthode appelée par la navbar
  void changePage(int index) {
    currentPageIndex.value = index;
  }

  List<String> listLabels = ['Explorer', 'Recettes', 'Frigos'];

  List<IconData> listIcon = [
    LucideIcons.home,
    LucideIcons.chefHat,
    LucideIcons.refrigerator,
  ];

  List<IconData> listIconSelected = [
    LucideIcons.home,
    LucideIcons.chefHat,
    LucideIcons.refrigerator,
  ];
}