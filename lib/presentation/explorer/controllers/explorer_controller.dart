import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/model/api/light_recipe.dart';
import 'package:partner_in_cook/model/api/recipe_list.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/services/recipe_list_service.dart';
import 'package:partner_in_cook/services/recipe_service.dart';
import 'package:partner_in_cook/services/tag_service.dart';
import 'package:partner_in_cook/presentation/recipe-list/controllers/recipe_list_controller.dart';

class ExplorerController extends GetxController {
  final searchController = TextEditingController();

  var allRecipes = <LightRecipe>[].obs;
  var filteredRecipes = <LightRecipe>[].obs;
  var recipeLists = <RecipeList>[].obs;

  var allRecipeLists = <RecipeList>[].obs;
  var filteredRecipeLists = <RecipeList>[].obs;

  var tags = <Tag>[].obs;
  var selectedTags = <Tag>[].obs;

  // 0 pour Recettes, 1 pour Listes de recettes
  var selectedTabIndex = 0.obs;

  var isLoading = true.obs;
  var isRecipeListLoading = false.obs;
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

  Future<void> loadRecipeLists() async {
    try {
      isRecipeListLoading.value = true;

      // Charger les listes owned et joined
      final owned = await recipeListApi.getOwned();
      print("Owned recipe lists loaded: ${owned.length}");

      final joined = await recipeListApi.getJoined();
      print("Joined recipe lists loaded: ${joined.length}");

      // Combiner les deux listes
      recipeLists.value = [...owned, ...joined];

      // Trier : les favoris en premier
      final sortedList = List<RecipeList>.from(recipeLists);
      sortedList.removeWhere((recipe) => recipe.isFavorite);
      recipeLists.value = sortedList;

      print("Total recipe lists: ${recipeLists.length}");
    } catch (e) {
      print("Error loading recipe lists: $e");
      recipeLists.value = [];
    } finally {
      isRecipeListLoading.value = false;
    }
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

  Future<void> addRecipeToList(String recipeListId, String recipeId) async {
    try {
      isRecipeListLoading.value = true;
      await recipeListApi.addToList(recipeListId, recipeId);
      await loadRecipeLists();

      recipeLists.refresh();

      if (Get.isRegistered<RecipeListController>()) {
        Get.find<RecipeListController>().loadRecipeList();
      }
    } catch (e) {
      print("Error loading recipe list details: $e");
    } finally {
      isRecipeListLoading.value = false;
    }
  }

  Future<void> removeRecipeFromSpecificList(
    String recipeListId,
    String recipeId,
  ) async {
    try {
      isRecipeListLoading.value = true;
      await recipeListApi.removeFromList(recipeListId, recipeId);
      await loadRecipeLists();

      recipeLists.refresh();

      if (Get.isRegistered<RecipeListController>()) {
        Get.find<RecipeListController>().loadRecipeList();
      }
    } catch (e) {
      print("Error loading recipe list details: $e");
    } finally {
      isRecipeListLoading.value = false;
    }
  }

  void showAddPlaylist(String recipeId) {
    loadRecipeLists();
    Get.bottomSheet(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          // On utilise Obx pour que la liste se mette à jour si loadRecipeLists est asynchrone
          child: Obx(() {
            if (isRecipeListLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryOrange,
                ),
              );
            }
            return Wrap(
              children: [
                // Correction de la syntaxe de la boucle for (ajout des parenthèses)
                for (var recipeList in recipeLists)
                  ListTile(
                    leading:
                        recipeList.pictureUrl != null &&
                            recipeList.pictureUrl!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ), // Ajustez la valeur du radius selon vos besoins
                            child: Image.network(
                              recipeList.pictureUrl!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.playlist_play),
                    title: Text(
                      style: const TextStyle(fontWeight: FontWeight.w700),
                      recipeList.name,
                    ),
                    subtitle: Text(
                      recipeList.recipes.length > 1
                          ? '${recipeList.recipes.length} recettes'
                          : '${recipeList.recipes.length} recette',
                    ),
                    trailing:
                        recipeList.recipes.any(
                          (recipe) => recipe.id == recipeId,
                        )
                        ? const Icon(LucideIcons.check, color: Colors.green)
                        : const Icon(
                            LucideIcons.plus,
                            color: AppColors.primaryOrange,
                          ),
                    onTap: () {
                      if (recipeList.recipes.any(
                        (recipe) => recipe.id == recipeId,
                      )) {
                        removeRecipeFromSpecificList(recipeList.id, recipeId);
                      } else {
                        addRecipeToList(recipeList.id, recipeId);
                      }
                    },
                  ),
                const SizedBox(height: 8, width: double.infinity),
              ],
            );
          }),
        ),
      ),
      isScrollControlled: false,
    );
  }
}
