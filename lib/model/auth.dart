import 'package:partner_in_cook/model/user.dart';

class Auth {
  final User user;
  final String token;

  Auth({required this.user, required this.token});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'token': token};
  }
}
