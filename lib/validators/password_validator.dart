import 'package:flutter/cupertino.dart';
import 'package:theo/validators/validator.dart';
import 'package:theo/values/error_messages.dart';

class PasswordValidator extends Validator<String?> {
  PasswordValidator(BuildContext context)
      : super(
          errorMessage: ErrorMessages.of(context).PASSWORD_MIN_LENGTH,
          validatorFunc: _validator,
        );

  static String? _validator({
    required String? value,
    required String errorMessage,
  }) {
    try {
      var text = value ?? '';
      if (text.isEmpty || text.length < 6) {
        return errorMessage;
      }
    } catch (err) {
      print('RequiredTextValidator._validator - $err');
      rethrow;
    }
  }
}
