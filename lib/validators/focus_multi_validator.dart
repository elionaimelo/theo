import 'package:flutter/cupertino.dart';

import 'package:theo/validators/validator.dart';

class FocusMultiValidator {
  FocusMultiValidator({
    required this.validators,
    required this.focusNode,
  });

  final FocusNode focusNode;
  List<Validator> validators;

  // Null   - is valid
  // String - with error
  String? isValid(dynamic value) {
    try {
      for (var validator in validators) {
        var result = validator.validate(value);

        if (result != null) {
          return result;
        }
      }
    } catch (err) {
      rethrow;
    }
  }

  String? call(dynamic value) {
    var result = isValid(value);

    if (result != null) {
      focusNode.requestFocus();
    }

    return result;
  }
}
