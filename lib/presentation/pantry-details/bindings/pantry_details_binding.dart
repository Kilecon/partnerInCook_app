import 'package:get/get.dart';

import '../controllers/pantry_details_controller.dart';

class PantryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PantryDetailsController>(
      () => PantryDetailsController(),
    );
  }
}
