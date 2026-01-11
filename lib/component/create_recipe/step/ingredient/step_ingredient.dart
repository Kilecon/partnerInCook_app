import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/component/create_recipe/step/ingredient/ingredient_modal.dart';
import 'package:partner_in_cook/component/widgets/add_btn.dart';
import 'package:partner_in_cook/component/widgets/info_chip.dart';
import 'package:partner_in_cook/presentation/create-recipe/controllers/create_recipe_controller.dart';

class StepIngredients extends GetView<CreateRecipeController> {
  const StepIngredients({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingrédients',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),

        Obx(
          () => Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.form.value.ingredients
                .map(
                  (i) => InfoChip(
                    icon: Icons.kitchen,
                    label:
                        '${i.quantity} ${i.ingredient.unit} ${i.ingredient.name}',
                  ),
                )
                .toList(),
          ),
        ),

        const SizedBox(height: 16),

        AddBtn(
          onTap: () {
            controller.resetIngredientModal();
            Get.dialog(const IngredientModal());
          },
        ),
      ],
    );
  }
}
