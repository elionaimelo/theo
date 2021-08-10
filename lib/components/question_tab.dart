import 'package:flutter/material.dart';
import 'package:theo/components/inputs/validation_error_text.dart';
import 'package:theo/components/option_button.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/validators/focus_multi_validator.dart';
import 'package:theo/validators/validator.dart';

class QuestionTabFormFieldProps {
  final String question;
  final List<String> options;
  final Function(int index) onSelectedIndex;
  final CrossAxisAlignment crossAxisAlign;
  final TextStyle? questionStyle;
  final bool centerOptions;
  final List<Validator> validators;
  final FocusNode focusNode;

  QuestionTabFormFieldProps({
    required this.question,
    required this.options,
    required this.onSelectedIndex,
    this.crossAxisAlign = CrossAxisAlignment.center,
    this.questionStyle,
    this.centerOptions = false,
    this.validators = const [],
    required this.focusNode,
  });
}

class QuestionTabFormField extends FormField<String?> {
  QuestionTabFormField(QuestionTabFormFieldProps props)
      : super(
          initialValue: '',
          validator: FocusMultiValidator(
            validators: props.validators,
            focusNode: props.focusNode,
          ),
          builder: (state) {
            return QuestionTabView(
              props: props,
              formState: state,
            );
          },
        );
}

class QuestionTabView extends StatelessWidget {
  const QuestionTabView({
    Key? key,
    required this.props,
    required this.formState,
  }) : super(key: key);

  final QuestionTabFormFieldProps props;
  final FormFieldState<String?> formState;

  String get selectedOption => formState.value ?? '';

  void _onOptionButtonTap(String text) {
    if (text == selectedOption) {
      text = '';
    }

    props.onSelectedIndex(props.options.indexOf(text));

    formState.didChange(text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: props.crossAxisAlign,
        children: [
          ValidationErrorText(
            errorText: formState.errorText,
            hasError: formState.hasError,
          ),
          _questionText(props.question, context),
          _content,
        ],
      ),
    );
  }

  Widget get _content => props.centerOptions
      ? Expanded(
          child: _questions,
        )
      : _questions;

  Widget get _questions => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: props.options
            .map(
              (e) => OptionButton(
                text: e,
                onTap: () => _onOptionButtonTap(e),
                selected: e == selectedOption,
              ),
            )
            .toList(),
      );

  Widget _questionText(String text, BuildContext context) => Text(
        text,
        style: props.questionStyle ??
            Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: TheoColors.seven,
                ),
      );
}
