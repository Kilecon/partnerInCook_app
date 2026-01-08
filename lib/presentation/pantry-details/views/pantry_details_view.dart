import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/fridge_details.dart/fridge_header.dart';
import 'package:partner_in_cook/component/fridge_details.dart/ingredient_list.dart';
import 'package:partner_in_cook/component/widgets/custom_layout.dart';
import 'package:partner_in_cook/component/widgets/fridge_description.dart';
import 'package:partner_in_cook/data/pantry_mock.dart';
import 'package:partner_in_cook/model/fridge_ingredient.dart';
import 'package:partner_in_cook/model/light_user.dart';
import 'package:partner_in_cook/model/pantry.dart';

import '../controllers/pantry_details_controller.dart';

class PantryDetailsView extends GetView<PantryDetailsController> {
  const PantryDetailsView({super.key});

  List<FridgeIngredientWOwner> convertPantryToIngredientsWithOwner(
    Pantry pantry,
  ) {
    // Map pour regrouper les ingrédients par ingredientId
    final Map<String, FridgeIngredientWOwner> mergedIngredients = {};

    // Parcourir tous les fridges
    for (var fridge in pantry.fridges) {
      // Pour chaque ingrédient du frigo
      for (var ingredient in fridge.ingredients) {
        final ingredientId = ingredient.ingredientId;

        if (mergedIngredients.containsKey(ingredientId)) {
          // Fusionner avec l'ingrédient existant
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
          // Créer un nouvel ingrédient
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

    // Convertir la map en liste et trier par ordre alphabétique
    final List<FridgeIngredientWOwner> ingredientsWithOwner = mergedIngredients
        .values
        .toList();

    ingredientsWithOwner.sort((a, b) {
      final nameA = a.ingredient?.name ?? '';
      final nameB = b.ingredient?.name ?? '';
      return nameA.toLowerCase().compareTo(nameB.toLowerCase());
    });

    return ingredientsWithOwner;
  }

  @override
  Widget build(BuildContext context) {
    Pantry pantry = pantryMock;
    final List<LightUser> members = pantry.fridges
        .map((fridge) => fridge.owner)
        .toList();
    final List<FridgeIngredientWOwner> ingredientsWithOwner =
        convertPantryToIngredientsWithOwner(pantry);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          FridgeHeader(ingredientsCount: ingredientsWithOwner.length),
          FridgeDescription(title: pantry.name, sharedUsers: members),
          Expanded(
            child: CustomLayout(
              useSafeArea: true,
              safeAreaTop: false,
              safeAreaBottom: true,
              verticalPadding: 0,
              spacing: 30,
              children: [
                // Utilisez ingredientsWithOwner ici au lieu de pantry.ingredients
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
  }
}
