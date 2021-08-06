import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/validators/focus_multi_validator.dart';
import 'package:theo/validators/validator.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    this.inputKey,
    this.hintText = '',
    this.label,
    this.labelStyle,
    this.labelMargin,
    required this.onTextChanged,
    this.maxLength,
    this.containerHeight,
    this.prefixWidget,
    this.obscureText = false,
    this.validators = const [],
    this.autoFocus = false,
  });

  final String hintText;
  final String? label;
  final TextStyle? labelStyle;
  final EdgeInsets? labelMargin;
  final int? maxLength;
  final Function(String) onTextChanged;
  final double? containerHeight;
  final Widget? prefixWidget;
  final bool obscureText;
  final List<Validator> validators;
  final bool autoFocus;
  final Key? inputKey;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  String currentText = '';
  final FocusNode focusNode = FocusNode();

  void _onTextChanged(String value) {
    setState(() {
      currentText = value;
    });
    widget.onTextChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) _label,
          Stack(
            children: [
              _inputWithHeight,
              if (widget.maxLength != null) _counterText,
            ],
          ),
        ],
      ),
    );
  }

  Widget get _inputWithHeight => widget.containerHeight != null
      ? Container(
          height: widget.containerHeight,
          child: _textFormInput,
        )
      : _textFormInput;

  Widget get _label => Container(
        margin: widget.labelMargin ?? EdgeInsets.only(bottom: 15),
        child: Text(
          widget.label!,
          style: widget.labelStyle ??
              GoogleFonts.muli(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: TheoColors.primary,
              ),
        ),
      );

  Widget get _textFormInput => TextFormField(
        key: widget.inputKey,
        autofocus: widget.autoFocus,
        focusNode: focusNode,
        validator: FocusMultiValidator(
          validators: widget.validators,
          focusNode: focusNode,
        ),
        maxLines: widget.obscureText ? 1 : null,
        minLines: null,
        obscureText: widget.obscureText,
        maxLength: widget.maxLength,
        textAlignVertical:
            _expands ? TextAlignVertical.top : TextAlignVertical.center,
        expands: _expands,
        onChanged: _onTextChanged,
        decoration: InputDecoration(
          prefixIcon: widget.prefixWidget,
          counterText: '',
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: TheoColors.fourteen,
                fontStyle: FontStyle.italic,
              ),
        ),
      );

  Widget get _counterText => Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          margin: EdgeInsets.only(bottom: 7, right: 12),
          child: Text(
            currentText.length.toString() + '/' + widget.maxLength.toString(),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: TheoColors.fourteen,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ),
      );

  bool get _expands => widget.containerHeight != null;
}
