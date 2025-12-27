import 'dart:convert';

import 'package:get/get.dart';
import 'package:partner_in_cook/model/auth.dart';
import 'package:partner_in_cook/model/user.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const String accessToken = 'accessToken';
  static const String user = 'user';
}

/// Service unifié gérant l'authentification et l'utilisateur courant.
/// Combine la persistance locale (SharedPreferences) et la gestion d'état réactive (GetX).
class AuthService extends GetxService {
  // État réactif de l'utilisateur et du token
  Rx<User?> user = Rx<User?>(null);
  Rx<String?> apiToken = Rx<String?>(null);
  Rx<bool> auth = false.obs;

  // Initialisation du service
  Future<AuthService> init() async {
    await _restoreAuth();

    // Persistance automatique des changements de token
    apiToken.listen((token) async {
      if (token == null) {
        await clearAuth();
        return;
      }

      if (user.value != null) {
        await _setAuthData(AuthRes(user: user.value!, token: token));
      }
    });
    return this;
  }

  // Restaure l'authentification depuis SharedPreferences
  Future<void> _restoreAuth() async {
    final authData = await getAuth();
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

  // Supprime l'utilisateur courant et déconnecte
  Future<void> removeCurrentUser() async {
    await logout();
    user.value = null;
    apiToken.value = null;
    auth.value = false;
  }

  // Définit l'authentification (user + token) avec persistance
  Future<void> setAuth(AuthRes authData) async {
    user.value = authData.user;
    apiToken.value = authData.token;
    auth.value = true;
    await _setAuthData(authData);
  }

  // Getter pour vérifier si l'utilisateur est authentifié
  bool get isAuth => auth.value;

  // Setter du token avec sauvegarde automatique
  void setApiToken(String? token) {
    apiToken.value = token;
    auth.value = token != null;
    if (token == null) {
      clearAuth();
    } else if (user.value != null) {
      _setAuthData(AuthRes(user: user.value!, token: token));
    }
  }

  // ========== Méthodes statiques pour SharedPreferences ==========

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(Constants.accessToken);
  }

  static Future<User?> getUser() async {
    final pref = await SharedPreferences.getInstance();
    final userJson = pref.getString(Constants.user);
    if (userJson == null) return null;

    try {
      final Map<String, dynamic> userMap =
          jsonDecode(userJson) as Map<String, dynamic>;
      return User.fromJson(userMap);
    } catch (_) {
      // Données corrompues : on nettoie et renvoie null
      await clearAuth();
      return null;
    }
  }

  static Future<AuthRes?> getAuth() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(Constants.accessToken);
    final userJson = pref.getString(Constants.user);

    if (token == null || userJson == null) return null;

    try {
      final Map<String, dynamic> userMap =
          jsonDecode(userJson) as Map<String, dynamic>;
      final user = User.fromJson(userMap);
      return AuthRes(user: user, token: token);
    } catch (_) {
      // Données corrompues : on nettoie et renvoie null
      await clearAuth();
      return null;
    }
  }

  static Future<void> _setAuthData(AuthRes auth) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.accessToken, auth.token);
    await pref.setString(Constants.user, jsonEncode(auth.user.toJson()));
  }

  static Future<void> clearAuth() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(Constants.accessToken);
    await pref.remove(Constants.user);
    Get.toNamed(Routes.login);
  }

  static Future<void> logout() => clearAuth();
}
