import 'package:get/get.dart';
import 'package:partner_in_cook/services/recipe_ingredient_service.dart';

import '../controllers/explorer_controller.dart';

class ExplorerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExplorerController>(
      () => ExplorerController(),
    );
    Get.lazyPut<RecipeIngredientService>(
      () => RecipeIngredientService(),
    );
  }
}
