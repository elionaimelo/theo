import 'package:theo/components/inputs/file_input.dart';
import 'package:theo/validators/validator.dart';
import 'package:theo/values/error_messages.dart';

class FileRequiredValidator extends Validator<List<SelectedFile>?> {
  FileRequiredValidator()
      : super(errorMessage: ErrorMessages.REQUIRED, validatorFunc: _validator);

  static String? _validator({
    required List<SelectedFile>? value,
    required String errorMessage,
  }) {
    try {
      if (value == null) return errorMessage;

      if (value.isEmpty) return errorMessage;
    } catch (err) {
      print('FileRequiredValidator._validator - $err');
      rethrow;
    }
  }
}
