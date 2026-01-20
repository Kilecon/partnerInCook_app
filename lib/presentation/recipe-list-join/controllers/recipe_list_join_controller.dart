import 'package:get/get.dart';
import 'package:partner_in_cook/services/recipe_list_service.dart';


class RecipeListJoinController extends GetxController {
  final isLoading = true.obs;
  final error = RxnString();

  late final String recipeListId;
  final recipeListApi = Get.find<RecipeListService>();

  @override
  void onInit() {
    recipeListId = Get.parameters['id']!;
    _joinRecipeList();
    super.onInit();
  }

  Future<void> _joinRecipeList() async {
    try {
      await recipeListApi.joined(recipeListId);

      Get.offNamed('/pantry/$recipeListId');
    } catch (e) {
      error.value = _mapError(e);
    } finally {
      isLoading.value = false;
    }
  }

  String _mapError(dynamic e) {
    // Adapter selon ton backend
    return 'Impossible de rejoindre le garde-manger';
  }
}
