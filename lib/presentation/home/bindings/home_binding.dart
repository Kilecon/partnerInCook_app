import 'package:get/get.dart';
import 'package:partner_in_cook/presentation/explorer/controllers/explorer_controller.dart';
import 'package:partner_in_cook/presentation/fridge/controllers/fridge_controller.dart';
import 'package:partner_in_cook/presentation/recipe-list/controllers/recipe_list_controller.dart';
import 'package:partner_in_cook/services/recipe_ingredient_service.dart';
import 'package:partner_in_cook/services/step_service.dart';

import '../controllers/home_manager_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeManagerController>(HomeManagerController());
    Get.lazyPut<ExplorerController>(() => ExplorerController());
    Get.lazyPut<FridgeController>(() => FridgeController());
    Get.lazyPut<RecipeListController>(() => RecipeListController());
    Get.lazyPut<RecipeIngredientService>(() => RecipeIngredientService());
    Get.lazyPut<StepService>(() => StepService());
  }
}
