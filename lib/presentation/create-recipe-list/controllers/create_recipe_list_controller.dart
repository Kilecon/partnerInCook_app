import 'package:get/get.dart';
import 'dart:io';
import 'package:partner_in_cook/component/widgets/errors_modal.dart';
import 'package:partner_in_cook/model/form/create_recipe_list_form.dart';
import 'package:partner_in_cook/model/form/field_error.dart';
import 'package:partner_in_cook/common/config/constants/visibility_state_enum.dart';
import 'package:partner_in_cook/presentation/recipe-list/controllers/recipe_list_controller.dart';
import 'package:partner_in_cook/services/recipe_list_service.dart';
import 'package:partner_in_cook/services/upload_service.dart';

class CreateRecipeListController extends GetxController {
  final recipeListApi = RecipeListService();
  final uploadService = UploadService();

  // ============================
  // FORM
  // ============================
  final form = CreateRecipeListForm().obs;

  // ============================
  // SETTERS pour mettre à jour le form
  // ============================
  void setName(String value) {
    form.update((val) {
      val?.name = value;
    });
  }

  void setDescription(String value) {
    form.update((val) {
      val?.description = value;
    });
  }

  void setVisibilityState(VisibilityStateEnum value) {
    form.update((val) {
      val?.visibilityState = value;
    });
  }

  void setImage(File? value) {
    form.update((val) {
      val?.image = value;
    });
  }

  // ============================
  // ERRORS
  // ============================
  final errors = <String, String>{}.obs;

  // ============================
  // LOADING STATE
  // ============================
  final isLoading = false.obs;

  // ============================
  // VALIDATION
  // ============================
  bool _validate() {
    errors.clear();
    if (form.value.name.trim().isEmpty) {
      errors['name'] = 'Nom requis';
    }

    return errors.isEmpty;
  }

  Future<void> createRecipeList() async {
    if (!_validate()) {
      final errs = errors.entries
          .map((e) => FieldError(e.key, e.value))
          .toList();
      Get.dialog(ErrorsModal(errors: errs));
      return;
    }

    try {
      isLoading.value = true;

      print('📝 Form values:');
      print('   Name: ${form.value.name}');
      print('   Description: ${form.value.description}');
      print('   Visibility: ${form.value.visibilityState}');
      print('   Has image: ${form.value.image != null}');

      // 1. Upload de l'image si présente
      if (form.value.image != null) {
        print('🖼️ Uploading image...');
        final imageUrl = await uploadService.uploadImage(form.value.image!);
        print('✅ Image URL: $imageUrl');
        form.update((val) {
          val?.imageUrl = imageUrl;
        });
      }

      print('📤 Creating recipe list...');

      // 2. Créer la liste de recettes
      await recipeListApi.create(form.value);

      print('✅ Recipe list created');

      // 3. Retourner à la page précédente

      final recipeListController = Get.find<RecipeListController>();
      await recipeListController.loadRecipeList();

      Get.back();

      // 4. Afficher un message de succès
      Get.snackbar(
        'Succès',
        'Liste de recettes créée avec succès'
      );
    } catch (e) {
      print('❌ Error: $e');
      Get.snackbar('Erreur', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
