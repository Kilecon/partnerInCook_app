import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/component/recipe_details/ingredient_content.dart';
import 'package:partner_in_cook/component/recipe_details/recipe_description.dart';
import 'package:partner_in_cook/component/recipe_details/recipe_header.dart';
import 'package:partner_in_cook/component/recipe_details/recipe_section.dart';
import 'package:partner_in_cook/component/recipe_details/utensil_content.dart';
import 'package:partner_in_cook/component/widgets/layout/custom_layout_body.dart';

import 'package:partner_in_cook/model/recipe.dart';

import '../controllers/recipe_details_controller.dart';

class RecipeDetailsView extends GetView<RecipeDetailsController> {
  const RecipeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;

    Recipe? recipe;
    String? fallbackId;

    if (args is Recipe) {
      recipe = args;
    } else if (args is Map<String, dynamic>) {
      try {
        recipe = Recipe.fromJson(args);
      } catch (_) {
        recipe = null;
      }
    } else if (args is String) {
      // parfois on envoie seulement l'id
      fallbackId = args;
    }

    // fallback: try Get.parameters (query params)
    final paramId = Get.parameters['id'];
    fallbackId ??= paramId;

    // TODO: utiliser `recipe` ou `fallbackId` dans ton controller

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const RecipeHeader(), // image + appbar + auteur (sliver)

          SliverToBoxAdapter(
            child: CustomLayoutBody(
              // variante sans ListView (BaseLayout + Column)
              children: const [
                RecipeDescriptionSection(), // titre, temps, tags
                SizedBox(height: 16),
                RecipeSection(
                  title: 'Ustensiles',
                  child: UstensilContent(), // contenu spécifique
                ),
                RecipeSection(
                  title: 'Ingrédients',
                  child: IngredientContent(), // check + qtt
                ),
                RecipeSection(
                  title: 'Préparation',
                  child: StepContent(), // étapes numérotées
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
