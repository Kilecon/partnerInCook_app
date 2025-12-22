import 'package:partner_in_cook/exceptions/app_exception.dart';

class ApiException extends AppException {
  ApiException(String message, {int? code}) : super(message, code: code);
}
