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

  void onDeleteRecipeList() {
    // Logique pour supprimer la liste de recettes
    Get.defaultDialog(
      title: 'Supprimer la liste',
      middleText:
          'Êtes-vous sûr de vouloir supprimer cette liste de recettes ?',
      textConfirm: 'Supprimer',
      textCancel: 'Annuler',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
        Get.back(); // Retour à la page précédente
        Get.snackbar(
          'Succès',
          'Liste supprimée avec succès',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void onEditRecipeList() {
    // Logique pour modifier la liste de recettes
    Get.snackbar(
      'Info',
      'Édition de la liste à implémenter',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
