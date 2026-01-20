import 'package:partner_in_cook/model/api/user.dart';

class AuthRes {
  final User user;
  final String token;
  final String refreshToken;

  AuthRes({required this.user, required this.token, required this.refreshToken});

  factory AuthRes.fromJson(Map<String, dynamic> json) {
    return AuthRes(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'token': token, 'refresh_token': refreshToken};
  }
}

class AuthLogin {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
  factory AuthLogin.fromJson(Map<String, dynamic> json) {
    return AuthLogin(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class AuthRegister {
  final String email;
  final String password;
  final String username;
  final String? picUrl; // optional

  AuthRegister({
    required this.email,
    required this.password,
    required this.username,
    this.picUrl,
  });
  factory AuthRegister.fromJson(Map<String, dynamic> json) {
    return AuthRegister(
      email: json['email'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
      picUrl: json['picUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'picUrl': picUrl,
    };
  }
}
