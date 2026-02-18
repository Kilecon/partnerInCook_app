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
import 'package:partner_in_cook/services/utensil_service.dart';

enum CreateRecipeStepPage { mainInfo, ingredients, utensils, steps }

class CreateRecipeController extends GetxController {
  final IngredientService _ingredientService = IngredientService();
  final UtensilService _utensilService = UtensilService();

  // ============================
  // STEP
  // ============================
  final currentStep = CreateRecipeStepPage.mainInfo.obs;

  // ============================
  // FORM
  // ============================
  final form = CreateRecipeForm().obs;

  // ============================
  // ERRORS
  // ============================
  final errors = <String, String>{}.obs;

  // ============================
  // API
  // ============================
  String? recipeId;

  // ============================
  // INGREDIENT MODAL STATE
  // ============================
  final Rxn<Ingredient> selectedIngredient = Rxn<Ingredient>();
  final quantityController = TextEditingController();
  int? editingIngredientIndex;

  // ============================
  // UTENSIL MODAL STATE
  // ============================
  final Rxn<Utensil> selectedUtensil = Rxn<Utensil>();
  final utensilQuantityController = TextEditingController();
  int? editingUtensilIndex;

  // ============================
  // STEPS (modal state + helpers)
  // ============================
  final stepDescriptionController = TextEditingController();
  final Rxn<Step> selectedStep = Rxn<Step>();
  int? editingStepIndex;

  // ============================
  // STEP NAVIGATION
  // ============================

  Future<void> next() async {
    if (!validate()) {
      final errs = errors.entries
          .map((e) => FieldError(e.key, e.value))
          .toList();
      Get.dialog(ErrorsModal(errors: errs));
      return;
    }

    if (currentStep.value.index == CreateRecipeStepPage.mainInfo.index) {
      await createRecipe();
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
  // VALIDATION
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
    }

    return errors.isEmpty;
  }

  // ============================
  // MAIN INFO
  // ============================

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
      errors['duration'] = 'Ajoute au moins une durée';
    }
  }

  // ============================
  // INGREDIENTS
  // ============================

  void _validateIngredients() {
    if (form.value.ingredients.isEmpty) {
      errors['ingredients'] = 'Ajoute au moins un ingrédient';
    }
  }

  // Future<List<Ingredient>> searchIngredients(String query) {
  //   return _ingredientService.searchIngredients(query);
  // }

  /// Ouverture modal en ajout
  void openAddIngredientModal() {
    editingIngredientIndex = null;
    selectedIngredient.value = null;
    quantityController.clear();
  }

  /// Ouverture modal en édition
  void openEditIngredientModal(int index) {
    final ing = form.value.ingredients[index];
    editingIngredientIndex = index;
    selectedIngredient.value = ing.ingredient;
    quantityController.text = ing.quantity.toString();
  }

  /// Validation modal (add OU edit)
  void validateIngredient() {
    final ingredient = selectedIngredient.value;
    final quantity = double.tryParse(quantityController.text);

    if (ingredient == null || quantity == null || quantity <= 0) {
      return;
    }

    form.update((f) {
      if (editingIngredientIndex != null) {
        f!.ingredients[editingIngredientIndex!] = CreateRecipeIngredient(
          ingredient: ingredient,
          quantity: quantity,
        );
      } else {
        f!.ingredients.add(
          CreateRecipeIngredient(ingredient: ingredient, quantity: quantity),
        );
      }
    });

    _resetIngredientModal();
    Get.back();
  }

  void removeIngredient(int index) {
    form.update((f) {
      f!.ingredients.removeAt(index);
    });
  }

  void _resetIngredientModal() {
    editingIngredientIndex = null;
    selectedIngredient.value = null;
    quantityController.clear();
  }

  // ============================
  // STEPS
  // ============================

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

  void openAddStepModal() {
    editingStepIndex = null;
    selectedStep.value = null;
    stepDescriptionController.text = '';
  }

  void openEditStepModal(int index) {
    final s = form.value.steps[index];
    editingStepIndex = index;
    selectedStep.value = s;
    stepDescriptionController.text = s.description;
  }

  void validateStep() {
    final desc = stepDescriptionController.text.trim();
    if (desc.isEmpty) return;
    form.update((f) {
      final current = f!.steps;
      if (editingStepIndex != null) {
        final old = current[editingStepIndex!];
        current[editingStepIndex!] = Step(
          id: old.id,
          description: desc,
          order: editingStepIndex! + 1,
          recipeId: old.recipeId,
        );
      } else {
        final newStep = Step(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          description: desc,
          order: current.length + 1,
          recipeId: recipeId ?? '',
        );
        current.add(newStep);
      }
      // normalize orders
      for (var i = 0; i < current.length; i++) {
        final s = current[i];
        current[i] = Step(
          id: s.id,
          description: s.description,
          order: i + 1,
          recipeId: s.recipeId,
        );
      }
    });
    _resetStepModal();
    Get.back();
  }

  void removeStep(int index) {
    form.update((f) {
      final current = f!.steps;
      current.removeAt(index);
      for (var i = 0; i < current.length; i++) {
        final s = current[i];
        current[i] = Step(
          id: s.id,
          description: s.description,
          order: i + 1,
          recipeId: s.recipeId,
        );
      }
    });
  }

  void reorderSteps(int oldIndex, int newIndex) {
    // Reorder list to reflect UI change
    form.update((f) {
      final list = List<Step>.from(f!.steps);
      if (newIndex > oldIndex) newIndex -= 1;
      final moved = list.removeAt(oldIndex);
      list.insert(newIndex, moved);
      for (var i = 0; i < list.length; i++) {
        final s = list[i];
        list[i] = Step(
          id: s.id,
          description: s.description,
          order: i + 1,
          recipeId: s.recipeId,
        );
      }
      f.steps = list;
    });
  }

  void _resetStepModal() {
    editingStepIndex = null;
    selectedStep.value = null;
    stepDescriptionController.clear();
  }

  // ============================
  // UTENSILS
  // ============================
  /// Ouverture modal en ajout
  void openAddUtensilModal() {
    editingUtensilIndex = null;
    selectedUtensil.value = null;
    utensilQuantityController.clear();
  }

  /// Ouverture modal en édition
  void openEditUtensilModal(int index) {
    final ut = form.value.utensils[index];
    editingUtensilIndex = index;
    selectedUtensil.value = ut;
  }

  void _validateUtensils() {
    if (form.value.utensils.isEmpty) {
      errors['utensils'] = 'Ajoute au moins un ustensile';
    }
  }

  Future<List<Utensil>> searchUtensils(String query) {
    return _utensilService.searchUtensils(query);
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

  /// Validation modal (add OU edit) pour ustensiles
  void validateUtensil() {
    final utensil = selectedUtensil.value;
    if (utensil == null) return;

    form.update((f) {
      if (editingUtensilIndex != null) {
        f!.utensils[editingUtensilIndex!] = utensil;
      } else {
        f!.utensils.add(utensil);
      }
    });

    _resetUtensilModal();
    Get.back();
  }

  void _resetUtensilModal() {
    editingUtensilIndex = null;
    selectedUtensil.value = null;
    utensilQuantityController.clear();
  }

  // ============================
  // TAGS & IMAGE
  // ============================

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
    utensilQuantityController.dispose();
    stepDescriptionController.dispose();
    super.onClose();
  }
}
