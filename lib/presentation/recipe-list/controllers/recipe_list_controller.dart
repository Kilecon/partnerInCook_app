import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
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
    final sortedList = List<RecipeList>.from(mockRecipeLists);
    sortedList.sort((a, b) => (b.isFavorite ? 1 : 0).compareTo(a.isFavorite ? 1 : 0));
    recipeList.value = sortedList;
  }

  void onRecipeListTap(String id) {
    Get.toNamed(Routes.recipeListDetails, arguments: id);
  }

  void onAddRecipeListTap() {
    // Gérer l'ajout d'une nouvelle liste de recettes
    Get.toNamed(Routes.createRecipe);
  }

  // Nouveau : affiche un bottom sheet pour choisir entre créer une recette ou une liste
  void showCreateOptions() {
    Get.bottomSheet(
      SafeArea(
        bottom: true,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(LucideIcons.utensilsCrossed, color: AppColors.primaryOrange,),
                title: const Text('Créer une recette'),
                onTap: () {
                  Get.back();
                  onCreateRecipeTap();
                },
              ),
              ListTile(
                leading: const Icon(LucideIcons.listPlus, color: AppColors.primaryOrange,),
                title: const Text('Créer une liste de recettes'),
                onTap: () {
                  Get.back();
                  onCreateRecipeListTap();
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      isScrollControlled: false,
    );
  }

  void onCreateRecipeTap() {
    Get.toNamed(Routes.createRecipe);
  }

  void onCreateRecipeListTap() {
    Get.toNamed(Routes.createRecipeList);
  }
}
