import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/component/explorer/recipe_list.dart';
import 'package:partner_in_cook/data/tag_mock.dart';
import 'package:partner_in_cook/model/api/recipe.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/services/recipe_list_service.dart';
import 'package:partner_in_cook/services/recipe_service.dart';
import 'package:partner_in_cook/services/tag_service.dart';

class ExplorerController extends GetxController {
  final searchController = TextEditingController();

  final RxList<Tag> selectedTag = <Tag>[].obs;
  var recipes = Rxn<Recipe>();
  var recipeLists = Rxn<RecipeList>();
  var tags = Rxn<List<Tag>>();

  var isLoading = false.obs;

  final recipeApi = RecipeService();
  final recipeListApi = RecipeListService();
  final tagApi = TagService();

  Future<void> loadData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        recipeApi.getAllPublic(),
        recipeListApi.getAllPublic(),
        tagApi.getAll(),
      ]);

      recipes.value = results[0] as Recipe;
      recipeLists.value = results[1] as RecipeList;
      tags.value = results[2] as List<Tag>;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onTagChanged(Tag tag) {
    selectedTag.value = [tag];
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
