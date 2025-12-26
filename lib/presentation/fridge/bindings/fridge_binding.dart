import 'package:get/get.dart';

import '../controllers/fridge_controller.dart';

class FridgeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FridgeController>(
      () => FridgeController(),
    );
  }
}
