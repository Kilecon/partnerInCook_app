import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/component/widgets/swipe_card.dart';
import 'package:partner_in_cook/component/fridge_details/ingredient_pantry_card.dart';
import 'package:partner_in_cook/model/api/fridge_ingredient.dart';
import 'package:partner_in_cook/component/widgets/empty_state.dart';
import 'package:partner_in_cook/presentation/fridge-details/controllers/fridge_details_controller.dart';

class IngredientsList extends StatelessWidget {
  final List<dynamic> ingredients; // Accepte les deux types
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
    final FridgeDetailsController controller =
        Get.find<FridgeDetailsController>();
    return ingredients.isEmpty
        ? EmptyState(
            message: isPantry
                ? "Le garde-manger est vide"
                : "Le frigo est vide",
            icon: isPantry ? LucideIcons.box : LucideIcons.refrigerator,
          )
        : Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10, width: 10),
              scrollDirection: axis,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final ingredient = ingredients[index];
                // Détecte le type et crée la carte appropriée
                if (ingredient is FridgeIngredientWOwner) {
                  return IngredientPantryCard(
                    fridgeIngredient: ingredient,
                    onTap: () {},
                  );
                } else {
                  return SwipeCard(
                    onTap: () {},
                    onDelete: () =>
                        controller.deleteIngredient(ingredient.ingredientId),
                    onEdit: () =>
                        controller.showEditQuantityDialog(context, ingredient),
                    name: ingredient.ingredient!.name,
                    unit: ingredient.ingredient!.unit,
                    quantity: ingredient.quantity,
                    iconUrl: ingredient.ingredient!.iconPictureUrl,
                  );
                }
              },
              itemCount: ingredients.length,
            ),
          );
  }
}
