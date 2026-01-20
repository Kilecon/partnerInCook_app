import 'package:get/get.dart';
import 'package:partner_in_cook/services/pantry_service.dart';

import '../controllers/pantry_details_controller.dart';

class PantryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PantryDetailsController>(
      () => PantryDetailsController(),
    );
    Get.lazyPut(() => PantryService());
  }
}
