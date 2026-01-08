import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/component/widgets/custom_input.dart';
import 'package:partner_in_cook/presentation/create-recipe/controllers/create_recipe_controller.dart';

class StepMainInfo extends GetView<CreateRecipeController> {
  const StepMainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Forcer la lecture de la map observable
      final errors = controller.errors.value;

      return Column(
        children: [
          CustomInput(
            title: 'Nom',
            hintText: 'Nom de la recette',
            onChanged: (v) => controller.form.value.name = v,
            validator: (_) => errors['name'],
          ),
          CustomInput(
            title: 'Description',
            hintText: 'Description',
            onChanged: (v) => controller.form.value.description = v,
          ),
          CustomInput(
            title: 'Portions',
            hintText: 'Ex: 2',
            onChanged: (v) =>
                controller.form.value.portions = int.tryParse(v) ?? 1,
            validator: (_) => errors['portions'],
          ),
        ],
      );
    });
  }
}
