import 'package:get/get.dart';
import 'package:partner_in_cook/model/api/fridge.dart';
import 'package:partner_in_cook/services/fridge_service.dart';

class FridgeDetailsController extends GetxController {
  var fridge = Rx<Fridge?>(null);
  var isLoading = true.obs;
  final fridgeApi = FridgeService();
  @override
  void onInit() {
    super.onInit();
    loadIngredientDetails();
  }
 Future<void> loadIngredientDetails() async {
    try {
      isLoading.value = true;
      final details = await fridgeApi.getOwned();
      fridge.value = details;
    } catch (e) {
      print("Error loading ingredient details: $e");
      fridge.value = null;
    } finally {
      isLoading.value = false;
    }
  }

}
