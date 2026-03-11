import 'package:get/get.dart';

import '../controllers/recipe_list_controller.dart';

class RecipeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeListController>(
      () => RecipeListController(),
    );
  }
}
