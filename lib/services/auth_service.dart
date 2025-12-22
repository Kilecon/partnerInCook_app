import 'dart:convert';

import 'package:partner_in_cook/model/auth.dart';
import 'package:partner_in_cook/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const String accessToken = 'accessToken';
  static const String user = 'user';
}

/// Gère la persistance locale de l'authentification (token + user) via SharedPreferences.
final class AuthService {
  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(Constants.accessToken);
  }

  static Future<Auth?> getAuth() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(Constants.accessToken);
    final userJson = pref.getString(Constants.user);

    if (token == null || userJson == null) return null;

    try {
      final Map<String, dynamic> userMap = jsonDecode(userJson) as Map<String, dynamic>;
      final user = User.fromJson(userMap);
      return Auth(user: user, token: token);
    } catch (_) {
      // Données corrompues : on nettoie et renvoie null
      await clearAuth();
      return null;
    }
  }

  static Future<void> setAuth(Auth auth) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.accessToken, auth.token);
    await pref.setString(Constants.user, jsonEncode(auth.user.toJson()));
  }

  static Future<void> clearAuth() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(Constants.accessToken);
    await pref.remove(Constants.user);
  }

  static Future<void> logout() => clearAuth();
}
