import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/data/light_recipe.dart';
import 'package:partner_in_cook/data/tag_mock.dart';
import 'package:partner_in_cook/model/api/light_recipe_list.dart';
import 'package:partner_in_cook/model/api/tag.dart';

class ExplorerController extends GetxController {
  /// Search
  final SearchController searchController = SearchController();

  /// Selected tag
  final Rx<Tag> selectedTag = tagsMock.first.obs;

  /// Recipes source
  final List<LightRecipe> _recipes = recipesLight;

  /// Filtered recipes (computed)
  List<LightRecipe> get filteredRecipes {
    var result = _recipes;

    // Exemple filtre tag (si besoin)
    if (selectedTag.value != tagsMock.first) {
      result = result
          .where((r) => r.tags!.contains(selectedTag.value))
          .toList();
    }

    final query = searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      result = result
          .where((r) => r.name.toLowerCase().contains(query))
          .toList();
    }

    return result;
  }

  void onTagChanged(Tag tag) {
    selectedTag.value = tag;
  }

  void onSearch() {
    update(); // force rebuild si nécessaire
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
