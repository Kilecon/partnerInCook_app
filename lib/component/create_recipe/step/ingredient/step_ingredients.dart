import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/create_recipe/modal/recipe_ingredient_modal.dart';
import 'package:partner_in_cook/component/widgets/add_btn_list.dart';
import 'package:partner_in_cook/component/widgets/swipe_card.dart';
import 'package:partner_in_cook/presentation/create-recipe/controllers/create_recipe_controller.dart';

class StepIngredients extends GetView<CreateRecipeController> {
  const StepIngredients({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ingredients = controller.form.value.ingredients;

      return Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Titre (aligné à gauche comme les inputs)
          const Text(
            'Ingrédients',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          /// Liste / Empty state
          if (ingredients.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text(
                  'Aucun ingrédient ajouté',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            Column(
              children: List.generate(ingredients.length, (index) {
                final i = ingredients[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SwipeCard(
                    backgroundColor: AppColors.background,
                    name: i.ingredient.name,
                    unit: i.ingredient.unit,
                    quantity: i.quantity,
                    iconUrl: i.ingredient.iconPictureUrl,
                    onDelete: () => controller.removeIngredient(index),
                    onEdit: () {
                      controller.openEditIngredientModal(index);
                      Get.dialog(const RecipeIngredientModal());
                    },
                  ),
                );
              }),
            ),

          /// Bouton ajouter (comme un champ de formulaire)
          SizedBox(
            width: double.infinity,
            child: AddBtnList(
              onTap: () {
                controller.openAddIngredientModal();
                Get.dialog(
                  const RecipeIngredientModal(),
                ); // Utilise le nouveau nom
              },
            ),
          ),
        ],
      );
    });
  }
}
