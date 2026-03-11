import 'package:get/get.dart';

import '../controllers/fridge_details_controller.dart';

class FridgeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FridgeDetailsController>(
      () => FridgeDetailsController(),
    );
  }
}
