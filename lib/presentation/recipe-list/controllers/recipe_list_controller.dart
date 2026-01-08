import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/data/recipe_list_mock.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/model/api/recipe_list.dart';

class RecipeListController extends GetxController {
  var recipeList = <RecipeList>[].obs;
  var searchController = TextEditingController();
 
  @override
  void onInit() {
    super.onInit();
    // Initialisation des données de test
    recipeList.value = mockRecipeLists;
  }

  void onRecipeListTap(String id) {
    Get.toNamed(Routes.recipeListDetails, arguments: id);
  }

  void onAddRecipeListTap() {
    // Gérer l'ajout d'une nouvelle liste de recettes
    Get.toNamed(Routes.createRecipe);
  }
}
