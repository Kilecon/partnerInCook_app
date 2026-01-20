import 'package:get/get.dart';
import 'package:partner_in_cook/component/widgets/errors_modal.dart';
import 'package:partner_in_cook/model/form/create_recipe_list_form.dart';
import 'package:partner_in_cook/model/form/field_error.dart';


class CreateRecipeListController extends GetxController {

  // ============================
  // FORM
  // ============================
  final form = CreateRecipeListForm().obs;

  // ============================
  // ERRORS
  // ============================
  final errors = <String, String>{}.obs;

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

  // ============================
  // API MOCK
  // ============================

  Future<void> createRecipeList() async {
    if (!_validate()) {
      final errs = errors.entries
          .map((e) => FieldError(e.key, e.value))
          .toList();
      Get.dialog(ErrorsModal(errors: errs));
      return;
    }
    await Future.delayed(const Duration(milliseconds: 400));
    print(  'Create recipe list: ${form.value.name}, '
        'Description: ${form.value.description}, '
        'Is Public: ${form.value.visibilityState}, '
        'Image: ${form.value.image}');
  }
}
