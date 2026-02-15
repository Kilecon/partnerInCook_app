import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/model/api/recipe_list.dart';
import 'package:partner_in_cook/services/recipe_list_service.dart';

class RecipeListController extends GetxController {
  var recipeList = <RecipeList>[].obs;
  var searchController = TextEditingController();
  final recipeListApi = RecipeListService();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadRecipeList();
  }

  Future<void> loadRecipeList() async {
    try {
      isLoading.value = true;

      // Charger les listes owned et joined
      final owned = await recipeListApi.getOwned();
      print("Owned recipe lists loaded: ${owned.length}");

      final joined = await recipeListApi.getJoined();
      print("Joined recipe lists loaded: ${joined.length}");

      // Combiner les deux listes
      recipeList.value = [...owned, ...joined];

      // Trier : les favoris en premier
      final sortedList = List<RecipeList>.from(recipeList);
      sortedList.sort(
        (a, b) => (b.isFavorite ? 1 : 0).compareTo(a.isFavorite ? 1 : 0),
      );
      recipeList.value = sortedList;

      print("Total recipe lists: ${recipeList.length}");
    } catch (e) {
      print("Error loading recipe lists: $e");
      recipeList.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  void onRecipeListTap(String id) {
    Get.toNamed(Routes.recipeListDetails, arguments: id);
  }

  void onMyRecipesTap() {
    Get.toNamed(Routes.recipeListDetails, arguments: 'my_recipes');
  }

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
                leading: const Icon(
                  LucideIcons.utensilsCrossed,
                  color: AppColors.primaryOrange,
                ),
                title: const Text('Créer une recette'),
                onTap: () {
                  Get.back();
                  onCreateRecipeTap();
                },
              ),
              ListTile(
                leading: const Icon(
                  LucideIcons.listPlus,
                  color: AppColors.primaryOrange,
                ),
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
