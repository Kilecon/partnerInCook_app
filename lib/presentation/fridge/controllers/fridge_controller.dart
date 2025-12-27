import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/data/fridge_mock.dart';
import 'package:partner_in_cook/data/pantry_mock.dart';
import 'package:partner_in_cook/model/fridge.dart';
import 'package:partner_in_cook/model/pantry.dart';
import 'package:partner_in_cook/model/tag.dart';

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

  void onPantryTap(Pantry pantry) {
    // Gérer la sélection du garde-manger
    print('Pantry tapped: ${pantry.name}');
  }

  void onFridgeTap(Fridge fridge) {
    // Gérer la sélection du frigo
    print('Fridge tapped: ${fridge.id}');
  }

  void onAddPantryTap() {
    // Gérer l'ajout d'un nouveau garde-manger
    print('Add Pantry tapped');
  }
}
