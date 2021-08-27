import 'package:flutter/cupertino.dart';
import 'package:theo/components/question_tab.dart';
import 'package:theo/validators/validator.dart';
import 'package:theo/values/error_messages.dart';

class OptionRequiredValidator extends Validator<OptionItem?> {
  OptionRequiredValidator(BuildContext context)
      : super(
            errorMessage: ErrorMessages.of(context).REQUIRED,
            validatorFunc: _validator);

  static String? _validator({
    required OptionItem? value,
    required String errorMessage,
  }) {
    try {
      if (value == null) return errorMessage;

      if (value.text.isEmpty) return errorMessage;
    } catch (err) {
      print('RequiredTextValidator._validator - $err');
      rethrow;
    }
  }
}
