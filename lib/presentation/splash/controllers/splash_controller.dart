import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_version.dart';

class SplashController extends GetxController {
  final version = versionNumber;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed('/home');
    });
  }
}
