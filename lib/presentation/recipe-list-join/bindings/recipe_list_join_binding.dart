import 'package:get/get.dart';
import 'package:partner_in_cook/presentation/recipe-list-join/controllers/recipe_list_join_controller.dart';
import 'package:partner_in_cook/services/recipe_list_service.dart';

class RecipeListJoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeListJoinController>(() => RecipeListJoinController());
    Get.lazyPut(() => RecipeListService());
  }
}
