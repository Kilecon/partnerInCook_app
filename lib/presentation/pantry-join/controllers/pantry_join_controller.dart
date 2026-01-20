import 'package:get/get.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/services/pantry_service.dart';

class PantryJoinController extends GetxController {
  final isLoading = true.obs;
  final error = RxnString();

  late final String pantryId;
  final pantryApiService = PantryService();

  @override
  void onInit() {
    pantryId = Get.parameters['id']!;
    _joinPantry();
    super.onInit();
  }

  Future<void> _joinPantry() async {
    try {
      await pantryApiService.joined(pantryId);

      Get.offAllNamed(Routes.pantryDetails, parameters: {'id': pantryId});
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
