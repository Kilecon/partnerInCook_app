import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';
import 'package:partner_in_cook/component/widgets/custom_button.dart';
import 'package:partner_in_cook/presentation/create-recipe/controllers/create_recipe_controller.dart';

class StepModal extends StatelessWidget {
  const StepModal({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateRecipeController>();

    return AppDialog(
      title: controller.editingStepIndex == null
          ? 'Ajouter une étape'
          : 'Modifier l\'étape',
      // utilisez le ValueListenable du TextEditingController au lieu d'Obx
      footer: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller.stepDescriptionController,
        builder: (_, value, __) {
          final disabled = value.text.trim().isEmpty;
          return CustomButton(
            name: controller.editingStepIndex == null
                ? 'Ajouter'
                : 'Enregistrer',
            isDisabled: disabled,
            onClick: controller.validateStep,
          );
        },
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller.stepDescriptionController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 3,
            decoration: const InputDecoration(hintText: 'Décrire l\'étape...'),
            autofocus: true,
          ),
        ],
      ),
    );
  }
}
