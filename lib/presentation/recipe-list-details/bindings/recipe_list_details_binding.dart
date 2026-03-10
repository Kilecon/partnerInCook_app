import 'package:get/get.dart';

import '../controllers/recipe_list_details_controller.dart';

class RecipeListDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeListDetailsController>(
      () => RecipeListDetailsController(),
    );
    
  }
}
