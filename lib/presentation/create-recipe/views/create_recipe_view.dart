import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/create_recipe/footer.dart';
import 'package:partner_in_cook/component/create_recipe/step_main.dart';
import 'package:partner_in_cook/component/widgets/back_header.dart';
import 'package:partner_in_cook/component/widgets/layout/custom_layout_body.dart';
import 'package:partner_in_cook/presentation/create-recipe/controllers/create_recipe_controller.dart';

class CreateRecipeView extends GetView<CreateRecipeController> {
  const CreateRecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          CreateRecipeHeader(
            title: 'Créer une recette',
            onBack: controller.back,
          ),

          Expanded(
            child: CustomLayoutBody(
              children: [
                Obx(() {
                  switch (controller.currentStep.value) {
                    case CreateRecipeStep.mainInfo:
                      return const StepMainInfo();
                    default:
                      return const SizedBox();
                  }
                }),
              ],
            ),
          ),

          Obx(
            () => CreateRecipeFooter(
              currentStep: controller.currentStep.value.index,
              totalSteps: CreateRecipeStep.values.length,
              onNext: controller.next,
            ),
          ),
        ],
      ),
    );
  }
}
