import 'package:get/get.dart';
import 'package:partner_in_cook/model/user.dart';
import 'package:partner_in_cook/services/auth_service.dart';

class ProfilController extends GetxController {
  User? user;

  @override
  Future<void> onInit() async {
    super.onInit();
    user = await AuthService.getUser();
  }

  void logout() {
    AuthService.logout();  
  }
}
