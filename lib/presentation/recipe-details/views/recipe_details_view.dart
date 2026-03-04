import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/recipe_details/ingredient_content.dart';
import 'package:partner_in_cook/component/recipe_details/recipe_description.dart';
import 'package:partner_in_cook/component/recipe_details/recipe_header.dart';
import 'package:partner_in_cook/component/recipe_details/recipe_section.dart';
import 'package:partner_in_cook/component/recipe_details/step_content.dart';
import 'package:partner_in_cook/component/recipe_details/utensil_content.dart';

import '../controllers/recipe_details_controller.dart';

class RecipeDetailsView extends GetView<RecipeDetailsController> {
  const RecipeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          // État chargement
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryOrange,
                strokeWidth: 2.5,
              ),
            );
          }

          final recipe = controller.recipe.value;

          // État erreur / introuvable
          if (recipe == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.lightGray,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Recette introuvable',
                    style: TextStyle(fontSize: 16, color: AppColors.lightGray),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Retour'),
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              RecipeHeader(
                user: recipe.author,
                icon: recipe.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                iconColor: recipe.isFavorite ? Colors.red : Colors.white,
                onTapAction: () => controller.toggleFavorite(),
                imageUrl: recipe.pictureUrl,
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RecipeDescriptionSection(recipe: recipe),
                    const SizedBox(height: 4),
                    RecipeSection(
                      title: 'Ingrédients',
                      child: IngredientContent(
                        ingredients: recipe.recipeIngredients,
                      ),
                    ),
                    RecipeSection(
                      title: 'Ustensiles',
                      child: UstensilContent(utensils: recipe.utensils),
                    ),
                    RecipeSection(
                      title: 'Préparation',
                      child: StepContent(steps: recipe.steps),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
