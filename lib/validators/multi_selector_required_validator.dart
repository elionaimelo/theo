import 'package:theo/components/inputs/multi_selector_button_input.dart';
import 'package:theo/validators/validator.dart';
import 'package:theo/values/error_messages.dart';

class MultiSelectorRequiredValidator extends Validator<List<SelectorItem>?> {
  MultiSelectorRequiredValidator()
      : super(errorMessage: ErrorMessages.REQUIRED, validatorFunc: _validator);

  static String? _validator({
    required List<SelectorItem>? value,
    required String errorMessage,
  }) {
    try {
      if (value == null) return errorMessage;

      if (value.isEmpty) return errorMessage;
    } catch (err) {
      print('RequiredMultiSelectorValidator._validator - $err');
      rethrow;
    }
  }
}
