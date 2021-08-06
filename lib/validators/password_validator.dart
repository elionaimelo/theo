import 'package:theo/validators/validator.dart';
import 'package:theo/values/error_messages.dart';

class PasswordValidator extends Validator<String?> {
  PasswordValidator()
      : super(
          errorMessage: ErrorMessages.INVALID_EMAIL,
          validatorFunc: _validator,
        );

  static String? _validator({
    required String? value,
    required String errorMessage,
  }) {
    try {
      if (value == null) return ErrorMessages.REQUIRED;

      if (value.isEmpty || value.length < 6) {
        return ErrorMessages.PASSWORD_MIN_LENGTH;
      }
    } catch (err) {
      print('RequiredTextValidator._validator - $err');
      rethrow;
    }
  }
}
