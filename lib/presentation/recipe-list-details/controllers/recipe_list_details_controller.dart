import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:partner_in_cook/data/recipe_list_mock.dart';
import 'package:partner_in_cook/model/recipe_list.dart';
import 'package:partner_in_cook/routes/app_pages.dart';

class RecipeListDetailsController extends GetxController {
  var recipeList = Rx<RecipeList?>(null);
  var searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Initialisation des données de test
    recipeList.value = mockRecipeLists[0];
  }

  void onRecipeTap(String recipeId) {
    // Logique pour gérer le tap sur une recette
    Get.toNamed(Routes.recipeDetails, arguments: recipeId);
  }
}
