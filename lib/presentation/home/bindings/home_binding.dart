import 'package:get/get.dart';

import '../controllers/home_manager_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeManagerController>(HomeManagerController());
  }
}
