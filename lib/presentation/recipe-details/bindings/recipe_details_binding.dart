import 'package:get/get.dart';

import '../controllers/recipe_details_controller.dart';

class RecipeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeDetailsController>(
      () => RecipeDetailsController(),
    );
  }
}
