import 'package:get/get.dart';
import 'package:partner_in_cook/model/create_recipe_form.dart';

enum CreateRecipeStep {
  mainInfo,
  ingredients,
  steps,
  utensils,
  tagsImage,
}

class CreateRecipeController extends GetxController {
  /// Step
  final currentStep = CreateRecipeStep.mainInfo.obs;

  /// Form
  final form = CreateRecipeForm().obs;

  /// Validation errors
  final errors = <String, String>{}.obs;

  /// API
  String? recipeId;

  // ----------------------------
  // STEP NAVIGATION
  // ----------------------------

  void next() async {
    if (!validate()) return;

    if (currentStep.value == CreateRecipeStep.mainInfo) {
      await createRecipe();
    }

    currentStep.value =
        CreateRecipeStep.values[currentStep.value.index + 1];
  }

  void back() {
    if (currentStep.value.index == 0) {
      Get.back();
      return;
    }
    currentStep.value =
        CreateRecipeStep.values[currentStep.value.index - 1];
  }

  // ----------------------------
  // VALIDATION (ZOD-LIKE)
  // ----------------------------

  bool validate() {
    errors.clear();

    switch (currentStep.value) {
      case CreateRecipeStep.mainInfo:
        if (form.value.name.isEmpty) {
          errors['name'] = 'Nom requis';
        }
        if (form.value.portions <= 0) {
          errors['portions'] = 'Portions invalides';
        }
        break;

      default:
        break;
    }

    return errors.isEmpty;
  }

  // ----------------------------
  // API MOCK
  // ----------------------------

  Future<void> createRecipe() async {
    await Future.delayed(const Duration(milliseconds: 400));
    recipeId = 'recipe-${DateTime.now().millisecondsSinceEpoch}';
  }
}
