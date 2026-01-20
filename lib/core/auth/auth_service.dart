import 'dart:convert';
import 'package:get/get.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/model/api/auth.dart';
import 'package:partner_in_cook/model/api/user.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String user = 'user';
}

/// Service gérant l'utilisateur et l'authentification
class AuthService extends GetxService {
  Rx<User?> user = Rx<User?>(null);
  Rx<String?> apiToken = Rx<String?>(null);
  Rx<String?> refreshToken = Rx<String?>(null);
  Rx<bool> auth = false.obs;

  /// Initialisation
  Future<AuthService> init() async {
    await _restoreAuth();

    // Persistance automatique des changements de token
    apiToken.listen((token) async {
      if (token == null) {
        await clearAuth();
        return;
      }
      if (user.value != null && refreshToken.value != null) {
        await _setAuthData(
          AuthRes(user: user.value!, token: token, refreshToken: refreshToken.value!),
        );
      }
    });

    return this;
  }

  /// Restaure l'auth depuis SharedPreferences
  Future<void> _restoreAuth() async {
    final authData = await getAuth();
    if (authData != null) {
      user.value = authData.user;
      apiToken.value = authData.token;
      refreshToken.value = authData.refreshToken;
      auth.value = true;
    } else {
      user.value = null;
      apiToken.value = null;
      refreshToken.value = null;
      auth.value = false;
    }
  }

  /// Déconnexion
  Future<void> removeCurrentUser() async {
    await logout();
    user.value = null;
    apiToken.value = null;
    refreshToken.value = null;
    auth.value = false;
  }

  /// Définit l'authentification (user + tokens)
  Future<void> setAuth(AuthRes authData) async {
    user.value = authData.user;
    apiToken.value = authData.token;
    refreshToken.value = authData.refreshToken;
    auth.value = true;
    await _setAuthData(authData);
  }

  bool get isAuth => auth.value;

  /// Refresh token automatique
  Future<bool> refreshAuthToken() async {
    if (refreshToken.value == null) return false;

    try {
      // Appel endpoint refresh
      final res = await Get.find<ApiClient>().post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken.value},
      );

      // Supposons que l'API renvoie { access_token: "...", refresh_token: "..." }
      final newToken = res.data['access_token'] as String?;
      final newRefresh = res.data['refresh_token'] as String?;

      if (newToken != null && newRefresh != null) {
        apiToken.value = newToken;
        refreshToken.value = newRefresh;
        return true;
      }

      return false;
    } catch (_) {
      await clearAuth();
      return false;
    }
  }

  // === SharedPreferences helpers ===

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(Constants.accessToken);
  }

  static Future<String?> getRefreshToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(Constants.refreshToken);
  }

  static Future<User?> getUser() async {
    final pref = await SharedPreferences.getInstance();
    final userJson = pref.getString(Constants.user);
    if (userJson == null) return null;

    try {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    } catch (_) {
      await clearAuth();
      return null;
    }
  }

  static Future<AuthRes?> getAuth() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(Constants.accessToken);
    final refresh = pref.getString(Constants.refreshToken);
    final userJson = pref.getString(Constants.user);

    if (token == null || userJson == null || refresh == null) return null;

    try {
      final user = User.fromJson(jsonDecode(userJson));
      return AuthRes(user: user, token: token, refreshToken: refresh);
    } catch (_) {
      await clearAuth();
      return null;
    }
  }

  static Future<void> _setAuthData(AuthRes auth) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.accessToken, auth.token);
    await pref.setString(Constants.refreshToken, auth.refreshToken);
      await pref.setString(Constants.user, jsonEncode(auth.user.toJson()));
  }

  static Future<void> clearAuth() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(Constants.accessToken);
    await pref.remove(Constants.refreshToken);
    await pref.remove(Constants.user);
    Get.toNamed(Routes.login);
  }

  static Future<void> logout() => clearAuth();
}
