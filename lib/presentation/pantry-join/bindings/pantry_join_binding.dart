import 'package:get/get.dart';

import '../controllers/pantry_join_controller.dart';

class PantryJoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PantryJoinController>(
      () => PantryJoinController(),
    );
  }
}
