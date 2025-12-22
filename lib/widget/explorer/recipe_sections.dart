import 'package:flutter/material.dart';
import 'package:partner_in_cook/model/recipe.dart';
import 'package:partner_in_cook/widget/header.dart';
import 'package:partner_in_cook/widget/recipes/recipe_list.dart';

class RecipeSections extends StatelessWidget {
  const RecipeSections({
    super.key,
    required this.latestRecipes,
    required this.filteredRecipes,
    required this.onRecipeTap,
  });

  final List<Recipe> latestRecipes;
  final List<Recipe> filteredRecipes;
  final VoidCallback onRecipeTap;

  @override
  Widget build(BuildContext context) {
    final hasLatest = latestRecipes.isNotEmpty;

    return Column(
      spacing: 5,
      children: [
        if (hasLatest) ...[
          Column(
            spacing: 5,
            children: [
              const SectionHeader(title: 'Dernières nouveautés'),
              SizedBox(
                height: 200,
                child: RecipeList(
                  recipes: latestRecipes,
                  axis: Axis.horizontal,
                  onRecipeTap: onRecipeTap,
                ),
              ),
            ],
          ),
        ],
        const SectionHeader(title: 'Liste des recettes', onSeeAll: null),
      ],
    );
  }
}
