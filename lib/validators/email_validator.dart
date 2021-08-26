import 'package:flutter/cupertino.dart';
import 'package:theo/validators/validator.dart';
import 'package:theo/values/error_messages.dart';

class EmailValidator extends Validator<String?> {
  EmailValidator(BuildContext context)
      : super(
          errorMessage: ErrorMessages.of(context).INVALID_EMAIL,
          validatorFunc: _validator,
        );

  static String? _validator({
    required String? value,
    required String errorMessage,
  }) {
    try {
      var emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value ?? '');

      if (!emailValid) {
        return errorMessage;
      }
    } catch (err) {
      print('RequiredTextValidator._validator - $err');
      rethrow;
    }
  }
}
