import 'package:flutter/material.dart' hide Step;
import 'package:get/get.dart';
import 'package:partner_in_cook/model/api/ingredient.dart';
import 'package:partner_in_cook/model/api/recipe_ingredient.dart';
import 'package:partner_in_cook/model/api/step.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/model/api/utensil.dart';
import 'package:partner_in_cook/model/form/create_recipe_form.dart';
import 'package:partner_in_cook/model/form/create_recipe_ingredient_form.dart';
import 'package:partner_in_cook/model/form/field_error.dart';
import 'package:partner_in_cook/component/widgets/errors_modal.dart';
import 'package:partner_in_cook/services/ingredient_service.dart';
import 'package:partner_in_cook/services/recipe_ingredient_service.dart';
import 'package:partner_in_cook/services/recipe_service.dart';
import 'package:partner_in_cook/services/step_service.dart';
import 'package:partner_in_cook/services/tag_service.dart';
import 'package:partner_in_cook/services/upload_service.dart';
import 'package:partner_in_cook/services/utensil_service.dart';
import 'package:partner_in_cook/presentation/recipe-list/controllers/recipe_list_controller.dart';

enum CreateRecipeStepPage { mainInfo, ingredients, utensils, steps }

class CreateRecipeController extends GetxController {
  // --- Services ---
  final IngredientService _ingredientService = IngredientService();
  final UtensilService _utensilService = UtensilService();
  final TagService _tagService = TagService();
  final RecipeService _recipeService = RecipeService();
  final UploadService _uploadService = UploadService();
  final StepService _stepService = StepService();
  final RecipeIngredientService _recipeIngredientService = RecipeIngredientService();

  // --- Observables (Données de l'API) ---
  final ingredientsLibrary = <Ingredient>[].obs;
  final utensilsLibrary = <Utensil>[].obs;
  final tagsLibrary = <Tag>[].obs;

  // --- État du Formulaire & Navigation ---
  final currentStep = CreateRecipeStepPage.mainInfo.obs;
  final form = CreateRecipeForm().obs;
  final isLoading = false.obs;
  final errors = <String, String>{}.obs;

  // --- États temporaires pour les Modals ---
  // Ingrédients
  final Rxn<Ingredient> selectedIngredient = Rxn<Ingredient>();
  final quantityController = TextEditingController();
  int? editingIngredientIndex;

  // Ustensiles
  final Rxn<Utensil> selectedUtensil = Rxn<Utensil>();
  int? editingUtensilIndex;

  // Étapes
  final stepDescriptionController = TextEditingController();
  int? editingStepIndex;

  @override
  void onInit() {
    super.onInit();
    _loadLibraries();
  }

  // --- Chargement des données nécessaires ---
  Future<void> _loadLibraries() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        _ingredientService.getAll(),
        _utensilService.getAll(),
        _tagService.getAll(),
      ]);
      ingredientsLibrary.value = results[0] as List<Ingredient>;
      utensilsLibrary.value = results[1] as List<Utensil>;
      tagsLibrary.value = results[2] as List<Tag>;
    } catch (e) {
      Get.snackbar("Erreur", "Impossible de charger les bibliothèques");
    } finally {
      isLoading.value = false;
    }
  }

  // --- Navigation ---
  Future<void> next() async {
    if (!validate()) {
      final errs = errors.entries.map((e) => FieldError(e.key, e.value)).toList();
      Get.dialog(ErrorsModal(errors: errs));
      return;
    }
    if (currentStep.value == CreateRecipeStepPage.steps) {
      await createRecipe();
    } else {
      currentStep.value = CreateRecipeStepPage.values[currentStep.value.index + 1];
    }
  }

  void back() {
    if (currentStep.value.index == 0) {
      Get.back();
    } else {
      currentStep.value = CreateRecipeStepPage.values[currentStep.value.index - 1];
    }
  }

  // --- Logique des TAGS ---
  void toggleTag(Tag tag) {
    form.update((f) {
      final index = f!.tags.indexWhere((t) => t.id == tag.id);
      if (index != -1) {
        f.tags.removeAt(index);
      } else {
        f.tags.add(tag);
      }
    });
  }

  // --- Logique des INGRÉDIENTS (Modal) ---
  void openAddIngredientModal() {
    editingIngredientIndex = null;
    selectedIngredient.value = null;
    quantityController.clear();
  }

  void openEditIngredientModal(int index) {
    final ing = form.value.ingredients[index];
    editingIngredientIndex = index;
    selectedIngredient.value = ing.ingredient;
    quantityController.text = ing.quantity.toString();
  }

  void validateIngredient() {
    final ingredient = selectedIngredient.value;
    final qty = double.tryParse(quantityController.text);

    if (ingredient == null || qty == null || qty <= 0) return;

    form.update((f) {
      if (editingIngredientIndex != null) {
        f!.ingredients[editingIngredientIndex!] = CreateRecipeIngredient(
          ingredient: ingredient,
          quantity: qty,
        );
      } else {
        f!.ingredients.add(CreateRecipeIngredient(ingredient: ingredient, quantity: qty));
      }
    });
    Get.back();
  }

  void removeIngredient(int index) {
    form.update((f) => f!.ingredients.removeAt(index));
  }

  // --- Logique des USTENSILES (Modal) ---
  void openAddUtensilModal() {
    editingUtensilIndex = null;
    selectedUtensil.value = null;
  }

  void openEditUtensilModal(int index) {
    editingUtensilIndex = index;
    selectedUtensil.value = form.value.utensils[index];
  }

  void validateUtensil() {
    final utensil = selectedUtensil.value;
    if (utensil == null) return;

    form.update((f) {
      if (editingUtensilIndex != null) {
        f!.utensils[editingUtensilIndex!] = utensil;
      } else {
        // Évite les doublons
        if (!f!.utensils.any((u) => u.id == utensil.id)) {
          f.utensils.add(utensil);
        }
      }
    });
    Get.back();
  }

  void removeUtensil(int index) {
    form.update((f) => f!.utensils.removeAt(index));
  }

  // --- Logique des ÉTAPES ---
  void openAddStepModal() {
    editingStepIndex = null;
    stepDescriptionController.clear();
  }

  void openEditStepModal(int index) {
    editingStepIndex = index;
    stepDescriptionController.text = form.value.steps[index].description;
  }

  void validateStep() {
    final desc = stepDescriptionController.text.trim();
    if (desc.isEmpty) return;

    form.update((f) {
      if (editingStepIndex != null) {
        f!.steps[editingStepIndex!] = StepCreateRequest(
          description: desc,
          order: editingStepIndex! + 1,
          recipeId: '', // Sera mis à jour à la création
        );
      } else {
        f!.steps.add(StepCreateRequest(
          description: desc,
          order: f.steps.length + 1,
          recipeId: '',
        ));
      }
    });
    Get.back();
  }

  void removeStep(int index) {
    form.update((f) {
      f!.steps.removeAt(index);
      // Réorganiser les ordres
      for (int i = 0; i < f.steps.length; i++) {
        f.steps[i] = StepCreateRequest(
          description: f.steps[i].description,
          order: i + 1,
          recipeId: '',
        );
      }
    });
  }

  void reorderSteps(int oldIndex, int newIndex) {
    form.update((f) {
      if (newIndex > oldIndex) newIndex -= 1;
      final moved = f!.steps.removeAt(oldIndex);
      f.steps.insert(newIndex, moved);
      // Recalculer les ordres
      for (int i = 0; i < f.steps.length; i++) {
        f.steps[i] = StepCreateRequest(
          description: f.steps[i].description,
          order: i + 1,
          recipeId: '',
        );
      }
    });
  }

  // --- Validation globale ---
  bool validate() {
    errors.clear();
    switch (currentStep.value) {
      case CreateRecipeStepPage.mainInfo:
        if (form.value.name.isEmpty) errors['name'] = 'Nom requis';
        if (form.value.portions <= 0) errors['portions'] = 'Portions invalides';
        if (form.value.preparationTime <= 0 && form.value.cookTime <= 0) {
          errors['duration'] = 'Ajoutez au moins une durée';
        }
        break;
      case CreateRecipeStepPage.ingredients:
        if (form.value.ingredients.isEmpty) errors['ingredients'] = 'Ajoutez un ingrédient';
        break;
      case CreateRecipeStepPage.utensils:
        if (form.value.utensils.isEmpty) errors['utensils'] = 'Ajoutez un ustensile';
        break;
      case CreateRecipeStepPage.steps:
        if (form.value.steps.isEmpty) errors['steps'] = 'Ajoutez une étape';
        break;
    }
    return errors.isEmpty;
  }

  // --- CRÉATION FINALE API ---
  Future<void> createRecipe() async {
    if (!validate()) return;

    // try {
      isLoading.value = true;

      // 1. Upload de l'image
      if (form.value.image != null) {
        final imageUrl = await _uploadService.uploadImage(form.value.image!);
        form.update((val) => val?.imageUrl = imageUrl);
      }
      print('Image uploadée: ${form.value.imageUrl}');
      // 2. Création de la Recette (Corps principal + IDs tags/ustensiles)
      final recipe = await _recipeService.create(form.value);
      print('Recette créée avec ID: ${recipe.id}');

      // 3. Création des ingrédients liés
      if (form.value.ingredients.isNotEmpty) {
        final ingredientsDto = form.value.ingredients.map((i) => RecipeIngredientCreateRequest(
          ingredientId: i.ingredient.id,
          quantity: i.quantity,
          recipeId: recipe.id,
        )).toList();
        await _recipeIngredientService.create(ingredientsDto);
      }

      // 4. Création des étapes
      if (form.value.steps.isNotEmpty) {
        final stepsDto = form.value.steps.map((s) => StepCreateRequest(
          description: s.description,
          order: s.order,
          recipeId: recipe.id,
        )).toList();
        await _stepService.create(stepsDto);
      }

      // 5. Finalisation
      Get.find<RecipeListController>().loadRecipeList();
      Get.back();
      Get.snackbar('Succès', 'Recette créée avec succès !');

    // } catch (e) {
    //   Get.snackbar('Erreur', 'Impossible de créer la recette');
    //   print('Erreur création recette: $e');
    // } finally {
    //   isLoading.value = false;
    // }
  }

  @override
  void onClose() {
    quantityController.dispose();
    stepDescriptionController.dispose();
    super.onClose();
  }
}