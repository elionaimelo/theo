import 'package:theo/types/functions.dart';
import 'package:theo/validators/validator.dart';
import 'package:theo/values/error_messages.dart';

class MatchPasswordValidator extends Validator<String?> {
  MatchPasswordValidator({required String matchValue})
      : super(
          errorMessage: ErrorMessages.INVALID_MATCH_PASSWORD,
          validatorFunc: _matchValidator(matchValue),
        );

  static ValidatorFunction<String?> _matchValidator(String matchValue) {
    String? _validator({
      required String? value,
      required String errorMessage,
    }) {
      try {
        if (value != matchValue) {
          return errorMessage;
        }
      } catch (err) {
        print('RequiredTextValidator._validator - $err');
        rethrow;
      }
    }

    return _validator;
  }
}
