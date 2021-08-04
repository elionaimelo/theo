import 'package:form_field_validator/form_field_validator.dart';

class TextSelectorValidator extends TextFieldValidator {
  // pass the error text to the super constructor
  TextSelectorValidator({required String errorText}) : super(errorText);

  // return false if you want the validator to return error
  // message when the value is empty.
  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    return value != null;
  }
}
