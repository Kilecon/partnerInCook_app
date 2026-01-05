import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:partner_in_cook/model/light_recipe_list.dart';
import 'package:partner_in_cook/component/widgets/empty_state.dart';
import 'package:partner_in_cook/component/explorer/recipe_horizontal_card.dart';
import 'package:partner_in_cook/component/explorer/recipe_large_card.dart';
import 'package:partner_in_cook/routes/app_pages.dart';

class RecipeList extends StatelessWidget {
  final List<LightRecipe> recipes;
  final Axis axis;
  const RecipeList({
    super.key,
    required this.recipes,
    this.axis = Axis.vertical,
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
                ? RecipeLargeCard(
                    recipe: recipes[index],
                    onTap: () => Get.toNamed(
                      Routes.recipeDetails,
                      arguments: recipes[index].id,
                    ),
                  )
                : RecipeHorizontalCard(
                    recipe: recipes[index],
                    onTap: () => Get.toNamed(
                      Routes.recipeDetails,
                      arguments: recipes[index].id,
                    ),
                  ),
            itemCount: recipes.length,
          );
  }
}
