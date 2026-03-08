import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/model/api/light_recipe.dart';
import 'package:partner_in_cook/model/api/recipe_list.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/services/recipe_list_service.dart';
import 'package:partner_in_cook/services/recipe_service.dart';
import 'package:partner_in_cook/services/tag_service.dart';

class ExplorerController extends GetxController {
  final searchController = TextEditingController();

  var allRecipes = <LightRecipe>[].obs;
  var filteredRecipes = <LightRecipe>[].obs;

  var allRecipeLists = <RecipeList>[].obs;
  var filteredRecipeLists = <RecipeList>[].obs;

  var tags = <Tag>[].obs;
  var selectedTags = <Tag>[].obs;

  // 0 pour Recettes, 1 pour Listes de recettes
  var selectedTabIndex = 0.obs;

  var isLoading = true.obs;
  final recipeApi = RecipeService();
  final recipeListApi = RecipeListService();
  final tagApi = TagService();

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_filterData);
    loadData();
  }

  void _filterData() {
    final query = searchController.text.toLowerCase().trim();

    // Filtrage des recettes
    var filteredR = allRecipes.toList();
    if (query.isNotEmpty) {
      filteredR = filteredR
          .where((r) => r.name.toLowerCase().contains(query))
          .toList();
    }
    if (selectedTags.isNotEmpty) {
      // La recette doit contenir TOUS les tags sélectionnés
      filteredR = filteredR.where((r) {
        if (r.tags == null || r.tags!.isEmpty) return false;
        final recipeTagIds = r.tags!.map((t) => t.id).toSet();
        return selectedTags.every((t) => recipeTagIds.contains(t.id));
      }).toList();
    }
    filteredRecipes.assignAll(filteredR);

    // Filtrage des listes de recettes
    var filteredRL = allRecipeLists.toList();
    if (query.isNotEmpty) {
      filteredRL = filteredRL
          .where((rl) => rl.name.toLowerCase().contains(query))
          .toList();
    }
    filteredRecipeLists.assignAll(filteredRL);
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        recipeApi.getAllPublic(),
        recipeListApi.getAllPublic(),
        tagApi.getAll(),
      ]);

      // Recettes
      final mappedRecipes = (results[0] as List)
          .map((r) => r.toLightRecipe())
          .toList();
      allRecipes.assignAll(mappedRecipes.cast<LightRecipe>());
      filteredRecipes.assignAll(mappedRecipes.cast<LightRecipe>());

      // Listes
      final rLists = results[1] as List<RecipeList>;
      allRecipeLists.assignAll(rLists);
      filteredRecipeLists.assignAll(rLists);

      // Tags
      final fetchedTags = results[2] as List<Tag>;
      tags.assignAll(fetchedTags);
    } catch (e) {
      print("Error loading explorer data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void toggleTag(Tag tag) {
    if (selectedTags.any((t) => t.id == tag.id)) {
      selectedTags.removeWhere((t) => t.id == tag.id);
    } else {
      selectedTags.add(tag);
    }
    _filterData();
  }

  void onRecipeTap(String id) {
    Get.toNamed(Routes.recipeDetails, arguments: id);
  }

  void onRecipeListTap(String id) {
    Get.toNamed(Routes.recipeListDetails, arguments: id);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
