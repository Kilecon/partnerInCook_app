import 'dart:ffi';

import 'package:get/get.dart';
import 'package:partner_in_cook/component/recipe_details/rating_dialog.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';
import 'package:partner_in_cook/model/api/notation.dart';
import 'package:partner_in_cook/model/api/recipe.dart';
import 'package:partner_in_cook/presentation/recipe-list-details/controllers/recipe_list_details_controller.dart';
import 'package:partner_in_cook/services/notation_service.dart';
import 'package:partner_in_cook/services/recipe_service.dart';

class RecipeDetailsController extends GetxController {
  var recipe = Rx<Recipe?>(null);
  final recipeApi = RecipeService();
  final notationApi = NotationService();

  final dynamic arguments = Get.arguments;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (arguments is String) {
      loadRecipeDetails(arguments);
    }
  }

  Future<void> loadRecipeDetails(String id) async {
    try {
      isLoading.value = true;
      final details = await recipeApi.getById(id);
      recipe.value = details;
    } catch (e) {
      print("Error loading recipe details: $e");
      recipe.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite() async {
    if (recipe.value == null) return;

    try {
      final newFavoriteStatus = !recipe.value!.isFavorite;
      await recipeApi.toggleFavorite(recipe.value!.id, newFavoriteStatus);

      recipe.value!.isFavorite = newFavoriteStatus;
      recipe.refresh(); // <-- Indispensable pour rafraîchir la vue avec GetX

      // Mettre à jour la liste des recettes en arrière-plan si le contrôleur existe
      if (Get.isRegistered<RecipeListDetailsController>()) {
        final listCtrl = Get.find<RecipeListDetailsController>();
        if (listCtrl.isMyRecipes) {
          listCtrl.loadMyRecipes();
        } else if (listCtrl.arguments is String) {
          listCtrl.loadRecipeListDetails(listCtrl.arguments);
        }
      }
    } catch (e) {
      print("Error toggling favorite: $e");
    }
  }

  Future<void> addNotation(int rating) async {
    try {
      isLoading.value = true;
      final currentUserId = await AuthService.getUserId();
      await notationApi.create(NotationCreateRequest(recipeId: recipe.value!.id, userId: currentUserId!, notation: rating));
    } catch (e) {
      print("Error loading recipe details: $e");
      recipe.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  void showAddNotationDialog() {
    if (recipe.value == null) return;

    Get.dialog(
      RatingDialog(
        title: 'Noter la recette',
        description: 'Veuillez attribuer une note à cette recette',
        onConfirm: (rating) {
            addNotation(rating);
          print("Notation attribuée : $rating étoiles");
        },
      ),
    );
  }
}
