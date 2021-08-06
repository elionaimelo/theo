import 'package:theo/validators/validator.dart';
import 'package:theo/values/error_messages.dart';

class TextRequiredValidator extends Validator<String?> {
  TextRequiredValidator()
      : super(errorMessage: ErrorMessages.REQUIRED, validatorFunc: _validator);

  static String? _validator({
    required String? value,
    required String errorMessage,
  }) {
    try {
      if (value == null) return errorMessage;

      if (value.isEmpty) return errorMessage;
    } catch (err) {
      print('RequiredTextValidator._validator - $err');
      rethrow;
    }
  }
}
