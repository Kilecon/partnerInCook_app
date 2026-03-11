import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/create_recipe/step/step/step_modal.dart';
import 'package:partner_in_cook/component/widgets/add_btn_list.dart';
import 'package:partner_in_cook/component/widgets/swipe_card.dart';
import 'package:partner_in_cook/presentation/create-recipe/controllers/create_recipe_controller.dart';

class StepSteps extends GetView<CreateRecipeController> {
  const StepSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final steps = controller.form.value.steps;

      return Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Étapes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          // Liste réordonnable — utilise shrinkWrap pour éviter les contraintes infinies
          if (steps.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Center(child: Text('Aucune étape')),
            )
          else
            ReorderableListView.builder(
              buildDefaultDragHandles: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: steps.length,
              onReorder: (oldIndex, newIndex) =>
                  controller.reorderSteps(oldIndex, newIndex),
              itemBuilder: (ctx, index) {
                final s = steps[index];

                return Dismissible(
                  key: ValueKey('step_$index'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    controller.removeStep(index);
                  },
                  child: Container(
                    // important: ensure the item has intrinsic width and height
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Drag handle for reordering
                        ReorderableDragStartListener(
                          index: index,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 8, top: 12),
                            child: Icon(Icons.drag_handle),
                          ),
                        ),

                        // The SwipeCard — use its API (pas de `child`)
                        Expanded(
                          child: SwipeCard(
                            backgroundColor: AppColors.background,
                            name: s.description.isEmpty
                                ? 'Étape ${index + 1}'
                                : s.description,
                            onTap: () {
                              controller.openEditStepModal(index);
                              Get.dialog(const StepModal());
                            },
                            onEdit: () {
                              controller.openEditStepModal(index);
                              Get.dialog(const StepModal());
                            },
                            onDelete: () => controller.removeStep(index),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          // Ajouter
          SizedBox(
            width: double.infinity,
            child: AddBtnList(
              onTap: () {
                controller.openAddStepModal();
                Get.dialog(const StepModal());
              },
            ),
          ),
        ],
      );
    });
  }
}
