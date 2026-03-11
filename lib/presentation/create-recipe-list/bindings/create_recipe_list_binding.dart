import 'package:get/get.dart';

import '../controllers/create_recipe_list_controller.dart';

class CreateRecipeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateRecipeListController>(
      () => CreateRecipeListController(),
    );
  }
}
