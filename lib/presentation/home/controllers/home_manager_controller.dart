import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeManagerController extends GetxController {
  var currentPageIndex = 0.obs;

  // Méthode appelée par la navbar
  void changePage(int index) {
    currentPageIndex.value = index;
  }

  List<String> listLabels = ['Accueil', 'Traitements', 'Profil'];

  List<IconData> listIcon = [
    Icons.home_outlined,
    Icons.summarize_outlined,
    Icons.person_outline,
  ];

  List<IconData> listIconSelected = [
    Icons.home,
    Icons.summarize,
    Icons.person,
  ];
}