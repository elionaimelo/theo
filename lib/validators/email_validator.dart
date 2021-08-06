import 'package:theo/validators/validator.dart';
import 'package:theo/values/error_messages.dart';

class EmailValidator extends Validator<String?> {
  EmailValidator()
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

      var emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);

      if (!emailValid) {
        return errorMessage;
      }
    } catch (err) {
      print('RequiredTextValidator._validator - $err');
      rethrow;
    }
  }
}
