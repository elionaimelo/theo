import 'package:theo/types/functions.dart';

class Validator<T> {
  Validator({
    required this.errorMessage,
    required this.validatorFunc,
  });

  final String errorMessage;
  final ValidatorFunction<T> validatorFunc;

  String? validate(dynamic value) {
    return validatorFunc(value: value, errorMessage: errorMessage);
  }
}
