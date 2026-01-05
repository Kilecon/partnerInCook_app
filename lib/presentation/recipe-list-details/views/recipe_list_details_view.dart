import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/component/explorer/recipe_large_card.dart';
import 'package:partner_in_cook/component/fridge/pantry_list.dart';
import 'package:partner_in_cook/component/recipe/recipe_header.dart';
import 'package:partner_in_cook/component/widgets/layout/custom_layout_body.dart';

import '../controllers/recipe_list_details_controller.dart';

class RecipeListDetailsView extends GetView<RecipeListDetailsController> {
  const RecipeListDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];

    for (var recipe in controller.recipeList.value?.recipes ?? []) {
      cards.add(
        RecipeLargeCard(
          recipe: recipe,
          onTap: () => controller.onRecipeTap(recipe.id),
        ),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const RecipeHeader(), // image + appbar + auteur (sliver)

          SliverToBoxAdapter(
            child: CustomLayoutBody(
              // variante sans ListView (BaseLayout + Column)
              children: [
                CardList(
                  cards: cards,
                  icon: LucideIcons.chefHat,
                  emptyString: "Aucune recette",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
