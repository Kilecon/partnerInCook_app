import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/visibility_state_enum.dart';
import 'package:partner_in_cook/component/widgets/custom_input.dart';
import 'package:partner_in_cook/component/widgets/custom_select.dart';
import 'package:partner_in_cook/component/widgets/image-selector.dart';
import 'package:partner_in_cook/presentation/create-recipe-list/controllers/create_recipe_list_controller.dart';

class CreateRecipeListForm extends GetView<CreateRecipeListController> {

  const CreateRecipeListForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Forcer la lecture de la map observable
      final errors = controller.errors.value;

      return Column(
        spacing: 10,
        children: [
          ImageSelector(
            title: 'Image de la liste de recettes',
            onImageSelect: (XFile? image) {},
          ),

          CustomSelect<VisibilityStateEnum>(
            prefixIcon: LucideIcons.lock,
            title: 'Visibilité',
            items: VisibilityStateEnum.values,
            value: controller.form.value.visibilityState,
            onChanged: (v) =>
                controller.form.update((f) => f!.visibilityState = v!),
            labelBuilder: (v) => visibilityStateToJson(v).capitalizeFirst ?? '',
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
        ],
      );
    });
  }
}
