import 'package:partner_in_cook/model/user.dart';

abstract class AuthService {
  Future<void> performAuth(User user);
}