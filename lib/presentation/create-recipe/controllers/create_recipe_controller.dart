import 'package:flutter/material.dart' hide Step;
import 'package:get/get.dart';
import 'package:partner_in_cook/model/api/ingredient.dart';
import 'package:partner_in_cook/model/api/step.dart';
import 'package:partner_in_cook/model/api/utensil.dart';
import 'package:partner_in_cook/model/form/create_recipe_form.dart';
import 'package:partner_in_cook/model/form/create_recipe_ingredient_form.dart';
import 'package:partner_in_cook/services/ingredient_service.dart';
import 'package:partner_in_cook/model/form/field_error.dart';
import 'package:partner_in_cook/component/widgets/errors_modal.dart';

enum CreateRecipeStepPage { mainInfo, ingredients, steps, utensils, tagsImage }

class CreateRecipeController extends GetxController {
  final _ingredientService = IngredientService();
  // ----------------------------
  // STEP
  // ----------------------------
  final currentStep = CreateRecipeStepPage.mainInfo.obs;

  // ----------------------------
  // FORM
  // ----------------------------
  final form = CreateRecipeForm().obs;

  // ----------------------------
  // ERRORS (ZOD-LIKE)
  // key = fieldName
  // ----------------------------
  final errors = <String, String>{}.obs;

  // ----------------------------
  // API
  // ----------------------------
  String? recipeId;

  // ============================
  // STEP NAVIGATION
  // ============================

  Future<void> next() async {
    if (!validate()) {
      // afficher la modal d'erreurs (similaire au design de IngredientModal)
      final errs = errors.entries.map((e) => FieldError(e.key, e.value)).toList();
      Get.dialog(ErrorsModal(errors: errs));
      return;
    }

    if (currentStep.value.index < CreateRecipeStepPage.values.length - 1) {
      currentStep.value =
          CreateRecipeStepPage.values[currentStep.value.index + 1];
    }
  }

  void back() {
    if (currentStep.value.index == 0) {
      Get.back();
      return;
    }

    currentStep.value =
        CreateRecipeStepPage.values[currentStep.value.index - 1];
  }

  // ============================
  // VALIDATION (STEP BASED)
  // ============================

  bool validate() {
    errors.clear();

    switch (currentStep.value) {
      case CreateRecipeStepPage.mainInfo:
        _validateMainInfo();
        break;

      case CreateRecipeStepPage.ingredients:
        _validateIngredients();
        break;

      case CreateRecipeStepPage.steps:
        _validateSteps();
        break;

      case CreateRecipeStepPage.utensils:
        _validateUtensils();
        break;

      case CreateRecipeStepPage.tagsImage:
        _validateTagsAndImage();
        break;
    }

    return errors.isEmpty;
  }

  // ----------------------------
  // MAIN INFO
  // ----------------------------
  void _validateMainInfo() {
    if (form.value.name.trim().isEmpty) {
      errors['name'] = 'Nom requis';
    }

    if (form.value.portions <= 0) {
      errors['portions'] = 'Nombre de portions invalide';
    }

    if (form.value.preparationTime <= 0 &&
        form.value.cookTime <= 0 &&
        form.value.restTime <= 0) {
      errors['duration'] = 'Durées requises';
    }
  }

  // ----------------------------
  // INGREDIENTS
  // ----------------------------
  final Rxn<Ingredient> selectedIngredient = Rxn<Ingredient>();
  final quantityController = TextEditingController();

  void _validateIngredients() {
    if (form.value.ingredients.isEmpty) {
      errors['ingredients'] = 'Ajoute au moins un ingrédient';
    }
  }

  Future<List<Ingredient>> searchIngredients(String query) async {
    return await _ingredientService.searchIngredients(query);
  }

  void resetIngredientModal() {
    selectedIngredient.value = null;
    quantityController.clear();
  }

  void validateIngredient() {
    final ingredient = selectedIngredient.value;
    if (ingredient == null) return;

    final quantity = double.tryParse(quantityController.text);
    if (quantity == null || quantity <= 0) return;

    addIngredient(
      CreateRecipeIngredient(ingredient: ingredient, quantity: quantity),
    );

    // Reset
    resetIngredientModal();
    Get.back();
  }

  void addIngredient(CreateRecipeIngredient ingredient) {
    form.update((f) {
      f!.ingredients.add(ingredient);
    });
  }

  void removeIngredient(int index) {
    form.update((f) {
      f!.ingredients.removeAt(index);
    });
  }

  // ----------------------------
  // STEPS
  // ----------------------------
  void _validateSteps() {
    if (form.value.steps.isEmpty) {
      errors['steps'] = 'Ajoute au moins une étape';
      return;
    }

    for (int i = 0; i < form.value.steps.length; i++) {
      if (form.value.steps[i].description.trim().isEmpty) {
        errors['steps.$i'] = 'Étape vide';
      }
    }
  }

  void addStep(Step step) {
    form.update((f) {
      f!.steps.add(step);
    });
  }

  void removeStep(int index) {
    form.update((f) {
      f!.steps.removeAt(index);
    });
  }

  // ----------------------------
  // UTENSILS
  // ----------------------------
  void _validateUtensils() {
    if (form.value.utensils.isEmpty) {
      errors['utensils'] = 'Ajoute au moins un ustensile';
    }
  }

  void addUtensil(Utensil utensil) {
    form.update((f) {
      f!.utensils.add(utensil);
    });
  }

  void removeUtensil(int index) {
    form.update((f) {
      f!.utensils.removeAt(index);
    });
  }

  // ----------------------------
  // TAGS & IMAGE
  // ----------------------------
  void _validateTagsAndImage() {
    if (form.value.tags.isEmpty) {
      errors['tags'] = 'Ajoute au moins un tag';
    }

    if (form.value.image == null) {
      errors['image'] = 'Image requise';
    }
  }

  // ============================
  // API MOCK
  // ============================

  Future<void> createRecipe() async {
    await Future.delayed(const Duration(milliseconds: 400));
    recipeId = 'recipe-${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  void onClose() {
    quantityController.dispose();
    super.onClose();
  }
}
