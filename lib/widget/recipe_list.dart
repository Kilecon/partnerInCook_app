import 'package:flutter/material.dart';
import 'package:partner_in_cook/model/recipe.dart';
import 'package:partner_in_cook/widget/empty_state.dart';
import 'package:partner_in_cook/widget/recipe_horizontal_card.dart';
import 'package:partner_in_cook/widget/recipe_large_card.dart';

class RecipeList extends StatelessWidget {
  final List<Recipe> recipes;
  final VoidCallback onRecipeTap;
  final Axis axis;
  const RecipeList({
    super.key,
    required this.recipes,
    this.axis = Axis.vertical,
    required this.onRecipeTap,
  });

  @override
  Widget build(BuildContext context) {
    return recipes.isEmpty
        ? EmptyState(message: "Aucune recettes disponibles")
        : ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10, width: 10),
            scrollDirection: axis,
            shrinkWrap: axis == Axis.vertical,
            physics: axis == Axis.vertical
                ? const NeverScrollableScrollPhysics()
                : null,
            itemBuilder: (BuildContext context, int index) =>
                axis == Axis.vertical
                ? RecipeLargeCard(recipe: recipes[index], onTap: onRecipeTap)
                : RecipeHorizontalCard(
                    recipe: recipes[index],
                    onTap: onRecipeTap,
                  ),
            itemCount: recipes.length,
          );
  }
}
