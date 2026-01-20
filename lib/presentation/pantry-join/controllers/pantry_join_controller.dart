import 'package:get/get.dart';
import 'package:partner_in_cook/services/pantry_service.dart';

class PantryJoinController extends GetxController {
  final isLoading = true.obs;
  final error = RxnString();

  late final String recipeListId;
  final pantryApiService = PantryService();


  @override
  void onInit() {
    recipeListId = Get.parameters['id']!;
    _joinRecipeList();
    super.onInit();
  }

  Future<void> _joinRecipeList() async {
    try {
      await pantryApiService.joined(recipeListId);

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
