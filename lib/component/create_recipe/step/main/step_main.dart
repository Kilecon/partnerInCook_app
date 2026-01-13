import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/create_recipe/step/main/durations.dart';
import 'package:partner_in_cook/component/create_recipe/step/main/portion.dart';
import 'package:partner_in_cook/component/explorer/tag_list.dart';
import 'package:partner_in_cook/component/widgets/custom_input.dart';
import 'package:partner_in_cook/component/widgets/image-selector.dart';
import 'package:partner_in_cook/data/tag_mock.dart';
import 'package:partner_in_cook/presentation/create-recipe/controllers/create_recipe_controller.dart';

class StepMainInfo extends GetView<CreateRecipeController> {
  const StepMainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Forcer la lecture de la map observable
      final errors = controller.errors.value;

      return Column(
        spacing: 10,
        children: [
          ImageSelector(
            title: 'Image de la recette',
            onImageSelect: (XFile? image) {},
          ),

          TagList(
            title: 'Catégories',
            selected: [tagsMock[0]],
            tags: tagsMock,
            onChanged: (_) {},
            color: AppColors.yellowPrimary,
          ),

          CustomInput(
            keyboardType: TextInputType.text,
            title: 'Nom',
            hintText: 'Nom de la recette',
            onChanged: (v) => controller.form.value.name = v,
            validator: (_) => errors['name'],
          ),

          CustomInput(
            keyboardType: TextInputType.text,
            title: 'Description',
            hintText: 'Description',
            onChanged: (v) => controller.form.value.description = v,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PortionsSelector(
                title: 'Portions',
                value: controller.form.value.portions,
                onIncrement: () => controller.form.update((f) => f!.portions++),
                onDecrement: () {
                  if (controller.form.value.portions > 1) {
                    controller.form.update((f) => f!.portions--);
                  }
                },
              ),
            ],
          ),

          DurationsSelector(
            title: 'Durées',
            preparation: controller.form.value.preparationTime,
            cook: controller.form.value.cookTime,
            rest: controller.form.value.restTime,
            onPrepTap: (val) =>
                controller.form.update((f) => f!.preparationTime = val),
            onCookTap: (val) =>
                controller.form.update((f) => f!.cookTime = val),
            onRestTap: (val) =>
                controller.form.update((f) => f!.restTime = val),
          ),
        ],
      );
    });
  }
}
