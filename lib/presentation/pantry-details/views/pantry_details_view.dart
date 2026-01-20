import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/fridge_details.dart/fridge_header.dart';
import 'package:partner_in_cook/component/fridge_details.dart/ingredient_list.dart';
import 'package:partner_in_cook/component/widgets/custom_layout.dart';
import 'package:partner_in_cook/component/widgets/fridge_description.dart';
import 'package:partner_in_cook/model/api/fridge_ingredient.dart';
import 'package:partner_in_cook/model/api/light_user.dart';
import 'package:partner_in_cook/model/api/pantry.dart';

import '../controllers/pantry_details_controller.dart';

class PantryDetailsView extends GetView<PantryDetailsController> {
  const PantryDetailsView({super.key});

  List<FridgeIngredientWOwner> convertPantryToIngredientsWithOwner(
    Pantry pantry,
  ) {
    final Map<String, FridgeIngredientWOwner> mergedIngredients = {};

    for (var fridge in pantry.fridges) {
      for (var ingredient in fridge.ingredients) {
        final ingredientId = ingredient.ingredientId;

        if (mergedIngredients.containsKey(ingredientId)) {
          final existing = mergedIngredients[ingredientId]!;
          mergedIngredients[ingredientId] = FridgeIngredientWOwner(
            id: existing.id,
            quantity: existing.quantity + ingredient.quantity,
            fridgeId: existing.fridgeId,
            ingredientId: ingredientId,
            ingredient: existing.ingredient,
            owners: [...existing.owners, fridge.owner],
          );
        } else {
          mergedIngredients[ingredientId] = FridgeIngredientWOwner(
            id: ingredient.id,
            quantity: ingredient.quantity,
            fridgeId: ingredient.fridgeId,
            ingredientId: ingredientId,
            ingredient: ingredient.ingredient,
            owners: [fridge.owner],
          );
        }
      }
    }

    final List<FridgeIngredientWOwner> ingredientsWithOwner =
        mergedIngredients.values.toList();

    ingredientsWithOwner.sort((a, b) {
      final nameA = a.ingredient?.name ?? '';
      final nameB = b.ingredient?.name ?? '';
      return nameA.toLowerCase().compareTo(nameB.toLowerCase());
    });

    return ingredientsWithOwner;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PantryDetailsController>(
      builder: (controller) {
        // Loader pendant l'appel API
        if (controller.isLoading.value) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Message d'erreur si échec API
        if (controller.pantry == null) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Impossible de charger le garde-manger.\nVérifiez votre connexion.',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final pantry = controller.pantry!;
        final members = pantry.fridges.map((f) => f.owner).toList();
        final ingredientsWithOwner =
            convertPantryToIngredientsWithOwner(pantry);

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              FridgeHeader(
                ingredientsCount: ingredientsWithOwner.length,
                onShareTap: () => controller.onShareTap(),
              ),
              FridgeDescription(title: pantry.name, sharedUsers: members),
              Expanded(
                child: CustomLayout(
                  useSafeArea: true,
                  safeAreaTop: false,
                  safeAreaBottom: true,
                  verticalPadding: 0,
                  spacing: 30,
                  children: [
                    IngredientsList(
                      ingredients: ingredientsWithOwner,
                      isPantry: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
