import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/data/fridge_mock.dart';
import 'package:partner_in_cook/data/pantry_mock.dart';
import 'package:partner_in_cook/model/api/fridge.dart';
import 'package:partner_in_cook/model/api/pantry.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/routes/app_pages.dart';

class FridgeController extends GetxController {
  var pantries = <Pantry>[].obs;
  var fridge = Rx<Fridge>(fridgeMock);
  var selectedTag = Rxn<Tag>();
  var searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Initialisation des données de test
    pantries.value = pantriesMock;
    fridge.value = fridgeMock;
  }

  void onPantryTap(String id) {
    // Gérer la sélection du garde-manger
    Get.toNamed(Routes.pantryDetails, arguments: id);
  }

  void onFridgeTap(String id) {
    Get.toNamed(Routes.fridgeDetails, arguments: id);
  }

  void onAddPantryTap() {
    // Gérer l'ajout d'un nouveau garde-manger
    print('Add Pantry tapped');
  }
}
