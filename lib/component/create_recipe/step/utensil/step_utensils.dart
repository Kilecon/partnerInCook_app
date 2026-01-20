import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/create_recipe/step/ingredient/ingredient_modal.dart';
import 'package:partner_in_cook/component/create_recipe/step/utensil/utensil_modal.dart';
import 'package:partner_in_cook/component/widgets/add_btn_list.dart';
import 'package:partner_in_cook/component/widgets/swipe_card.dart';
import 'package:partner_in_cook/presentation/create-recipe/controllers/create_recipe_controller.dart';

class StepUtensils extends GetView<CreateRecipeController> {
  const StepUtensils({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final utensils = controller.form.value.utensils;

      return Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Titre (aligné à gauche comme les inputs)
          const Text(
            'Ustensiles',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          /// Liste / Empty state
          if (utensils.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text(
                  'Aucun ustensile ajouté',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            Column(
              children: List.generate(utensils.length, (index) {
                final i = utensils[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SwipeCard(
                    backgroundColor: AppColors.background,
                    name: i.name,
                    iconUrl: i.iconPictureUrl,
                    onDelete: () => controller.removeUtensil(index),
                    onEdit: () {
                      controller.openAddUtensilModal();
                      Get.dialog(const UtensilModal());
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
                controller.openAddUtensilModal();
                Get.dialog(const UtensilModal());
              },
            ),
          ),
        ],
      );
    });
  }
}
