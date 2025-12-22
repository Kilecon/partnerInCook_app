import 'package:get/get.dart';
import 'package:partner_in_cook/model/auth.dart';
import 'package:partner_in_cook/model/user.dart';
import 'package:partner_in_cook/services/auth_service.dart';

class UserService extends GetxService {
  Rx<User?> user = Rx<User?>(null);
  Rx<String?> apiToken = Rx<String?>(null);
  Rx<bool> auth = false.obs;

  Future<UserService> init() async {
    await _restoreAuth();

    // Persistance automatique des changements de token
    apiToken.listen((token) async {
      if (token == null) {
        await AuthService.clearAuth();
        return;
      }

      if (user.value != null) {
        await AuthService.setAuth(Auth(user: user.value!, token: token));
      }
    });
    return this;
  }

  Future<void> _restoreAuth() async {
    final authData = await AuthService.getAuth();
    if (authData != null) {
      user.value = authData.user;
      apiToken.value = authData.token;
      auth.value = true;
    } else {
      user.value = null;
      apiToken.value = null;
      auth.value = false;
    }
  }

  Future<void> removeCurrentUser() async {
    await AuthService.logout();
    user.value = null;
    apiToken.value = null;
    auth.value = false;
  }

  Future<void> setAuth(Auth authData) async {
    user.value = authData.user;
    apiToken.value = authData.token;
    auth.value = true;
    await AuthService.setAuth(authData);
  }

  bool get isAuth => auth.value;

  // ✅ Setter du token avec sauvegarde automatique
  void setApiToken(String? token) {
    apiToken.value = token;
    auth.value = token != null;
    if (token == null) {
      AuthService.clearAuth();
    } else if (user.value != null) {
      AuthService.setAuth(Auth(user: user.value!, token: token));
    }
  }
}
