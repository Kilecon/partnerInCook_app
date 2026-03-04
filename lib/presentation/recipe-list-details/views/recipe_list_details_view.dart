import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/explorer/recipe_large_card.dart';
import 'package:partner_in_cook/component/fridge/card_list.dart';
import 'package:partner_in_cook/component/recipe_details/recipe_header.dart';
import 'package:partner_in_cook/component/recipe-list-detail/recipe_list_info.dart';
import 'package:partner_in_cook/component/widgets/layout/custom_layout_body.dart';

import '../controllers/recipe_list_details_controller.dart';

class RecipeListDetailsView extends GetView<RecipeListDetailsController> {
  const RecipeListDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.recipeList.value == null) {
          return const Center(child: Text('Erreur de chargement'));
        }

        List<Widget> cards = [];
        for (var recipe in controller.recipeList.value?.recipes ?? []) {
          cards.add(
            RecipeLargeCard(
              recipe: recipe,
              onTap: () => controller.onRecipeTap(recipe.id),
              onDelete: () => controller.removeRecipeFromList(recipe.id),
              onEdit: () => controller.addRecipeToList(recipe.id),
            ),
          );
        }

        return SafeArea(
          top: false,
          child: CustomScrollView(
            slivers: [
              RecipeHeader(
                user: controller.recipeList.value!.author,
                icon: LucideIcons.share2,
                onTapAction: () => controller.onShareTap(),
                imageUrl: controller.recipeList.value?.pictureUrl,
                canShare: controller.qrImage != null && !controller.recipeList.value!.isFavorite && !controller.isMyRecipes,
              ), // image + appbar + auteur (sliver)

              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                sliver: SliverToBoxAdapter(
                  child: CustomLayoutBody(
                    spacing: 20,
                    horizontalPadding: 0,
                    verticalPadding: 0,
                    children: [
                      if (controller.recipeList.value != null)
                        RecipeListInfo(
                          recipeList: controller.recipeList.value!,
                          onDelete: () => controller.onDeleteRecipeList(),
                          onEdit: () => controller.onEditRecipeList(),
                          isMyRecipes: controller.isMyRecipes,
                          isFavorite: controller.recipeList.value!.isFavorite,
                          isMyPlaylist: controller.isMyPlaylist,
                        ),
                      CardList(
                        cards: cards,
                        icon: LucideIcons.chefHat,
                        emptyString: "Aucune recette",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
