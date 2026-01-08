import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/recipe_details/ingredient_content.dart';
import 'package:partner_in_cook/component/recipe_details/recipe_description.dart';
import 'package:partner_in_cook/component/recipe_details/recipe_header.dart';
import 'package:partner_in_cook/component/recipe_details/recipe_section.dart';
import 'package:partner_in_cook/component/recipe_details/utensil_content.dart';
import 'package:partner_in_cook/component/widgets/layout/custom_layout_body.dart';

import '../controllers/recipe_details_controller.dart';

class RecipeDetailsView extends GetView<RecipeDetailsController> {
  const RecipeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          RecipeHeader(user: controller.recipe.author, icon: LucideIcons.heart, onTapAction: () {}, imageUrl: controller.recipe.pictureUrl), // image + appbar + auteur (sliver)

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
