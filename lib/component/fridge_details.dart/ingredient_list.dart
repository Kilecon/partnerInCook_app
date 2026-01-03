import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/component/fridge_details.dart/ingredient_fridge_card.dart';
import 'package:partner_in_cook/model/fridge_ingredient.dart';
import 'package:partner_in_cook/model/recipe.dart';
import 'package:partner_in_cook/component/widgets/empty_state.dart';
import 'package:partner_in_cook/component/explorer/recipe_horizontal_card.dart';
import 'package:partner_in_cook/component/explorer/recipe_large_card.dart';
import 'package:partner_in_cook/routes/app_pages.dart';

class IngredientsList extends StatelessWidget {
  final List<FridgeIngredient> ingredients;
  final bool isPantry;
  final Axis axis;
  const IngredientsList({
    super.key,
    required this.ingredients,
    this.axis = Axis.vertical,
    this.isPantry = false,
  });

  @override
  Widget build(BuildContext context) {
    return ingredients.isEmpty
        ? EmptyState(message: isPantry ? "Le garde-manger est vide" : "Le frigo est vide", icon: isPantry ? LucideIcons.box : LucideIcons.refrigerator,)
        : ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10, width: 10),
            scrollDirection: axis,
            shrinkWrap: axis == Axis.vertical,
            physics: axis == Axis.vertical
                ? const NeverScrollableScrollPhysics()
                : null,
            itemBuilder: (BuildContext context, int index) => IngredientFridgeCard(
              fridgeIngredient: ingredients[index],
              onTap: () {},
            ),

            itemCount: ingredients.length,
          );
  }
}
