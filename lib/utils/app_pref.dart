import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const String accessToken = 'accessToken';
  static const String user = 'user';
}

final class AppPref {
  static Future<String?>? getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(Constants.accessToken);
  }

  static Future<bool> setToken(String value) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(Constants.accessToken, value);
  }

  static Future<bool> deleteToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(Constants.accessToken);
  }

  static Future<void> logout() async {
    final accessToken = await SharedPreferences.getInstance();
    await accessToken.remove(Constants.accessToken);
  }
}