import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/component/create_recipe/footer.dart';
import 'package:partner_in_cook/component/create_recipe/step/ingredient/step_ingredients.dart';
import 'package:partner_in_cook/component/create_recipe/step/main/step_main.dart';
import 'package:partner_in_cook/component/create_recipe/step/step/step_steps.dart';
import 'package:partner_in_cook/component/create_recipe/step/utensil/step_utensils.dart';
import 'package:partner_in_cook/component/widgets/back_header.dart';
import 'package:partner_in_cook/component/widgets/custom_layout.dart';
import 'package:partner_in_cook/presentation/create-recipe/controllers/create_recipe_controller.dart';

class CreateRecipeView extends GetView<CreateRecipeController> {
  const CreateRecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          BackHeader(title: controller.isEditMode ? 'Modifier la recette' : 'Créer une recette', onBack: controller.back),

          Expanded(
            child: CustomLayout(
              children: [
                Obx(() {
                  switch (controller.currentStep.value) {
                    case CreateRecipeStepPage.mainInfo:
                      return const StepMainInfo();
                    case CreateRecipeStepPage.ingredients:
                      return const StepIngredients();
                    case CreateRecipeStepPage.utensils:
                      return const StepUtensils();
                    case CreateRecipeStepPage.steps:
                      return const StepSteps();
                  }
                }),
              ],
            ),
          ),

          Obx(
            () => CreateRecipeFooter(
              currentStep: controller.currentStep.value.index,
              totalSteps: CreateRecipeStepPage.values.length,
              onNext: controller.next,
              isLoading: controller.isLoading.value,
            ),
          ),
        ],
      ),
    );
  }
}
