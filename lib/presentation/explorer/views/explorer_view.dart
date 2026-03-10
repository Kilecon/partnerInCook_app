import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/custom_app_bar.dart';
import 'package:partner_in_cook/component/widgets/custom_layout.dart';
import 'package:partner_in_cook/component/widgets/title_page.dart';
import 'package:partner_in_cook/component/fridge/card_list.dart';
import 'package:partner_in_cook/component/explorer/recipe_large_card.dart';
import 'package:partner_in_cook/component/recipe-list/recipe_list_card.dart';
import 'package:partner_in_cook/component/explorer/tag_list.dart';

import '../controllers/explorer_controller.dart';

class ExplorerView extends GetView<ExplorerController> {
  const ExplorerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(),
      body: Container(
        color: AppColors.background,
        child: Column(
          children: [
            TitlePage(
              hasSearchBar: true,
              title: 'Explorer',
              subtitle: 'Découvrez des milliers de recettes',
              searchController: controller.searchController,
              data:
                  const [], // TitlePage réclame data et onSearchResultTap si hasSearchBar == true
              onSearchResultTap:
                  () {}, // Fonction vide pour éviter le Null check
            ),

            // Barre de sélection de l'onglet : Recettes ou Listes
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12,
              ),
              child: Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: _TabButton(
                        title: "Recettes",
                        isSelected: controller.selectedTabIndex.value == 0,
                        onTap: () => controller.selectedTabIndex.value = 0,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _TabButton(
                        title: "Listes",
                        isSelected: controller.selectedTabIndex.value == 1,
                        onTap: () => controller.selectedTabIndex.value = 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryOrange,
                    ),
                  );
                }

                final isRecipesTab = controller.selectedTabIndex.value == 0;
                List<Widget> cards = [];
                String emptyMsg = "";
                IconData listIcon = LucideIcons.chefHat;
                int resultsCount = 0;

                if (isRecipesTab) {
                  final filtered = controller.filteredRecipes;
                  resultsCount = filtered.length;
                  cards = filtered.map((recipe) {
                    return RecipeLargeCard(
                      recipe: recipe,
                      onAdd: () => controller.showAddPlaylist(recipe.id),
                      onTap: () => controller.onRecipeTap(recipe.id),
                    );
                  }).toList();

                  emptyMsg = controller.searchController.text.isEmpty
                      ? "Pas encore de recettes publiques"
                      : "Aucune recette ne correspond à votre recherche";
                  listIcon = LucideIcons.chefHat;
                } else {
                  final filtered = controller.filteredRecipeLists;
                  resultsCount = filtered.length;
                  cards = filtered.map((recipeList) {
                    return RecipeListCard(
                      recipeList: recipeList,
                      onTap: () => controller.onRecipeListTap(recipeList.id),
                    );
                  }).toList();

                  emptyMsg = controller.searchController.text.isEmpty
                      ? "Pas encore de listes publiques"
                      : "Aucune liste ne correspond à votre recherche";
                  listIcon = Icons.list_alt;
                }

                return RefreshIndicator(
                  color: AppColors.primaryOrange,
                  onRefresh: controller.loadData,
                  child: CustomLayout(
                    verticalPadding: 0,
                    horizontalPadding: 16,
                    children: [
                      // Affiche les tags uniquement pour les recettes
                      if (isRecipesTab && controller.tags.isNotEmpty) ...[
                        TagList(
                          selected: controller.selectedTags.toList(),
                          tags: controller.tags.toList(),
                          onChanged: controller.toggleTag,
                        ),
                      ],

                      if (controller.searchController.text.isNotEmpty ||
                          controller.selectedTags.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            '$resultsCount résultat(s)',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),

                      CardList(
                        icon: listIcon,
                        cards: cards,
                        emptyString: emptyMsg,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryOrange : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryOrange : Colors.grey[300]!,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryOrange.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
