import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/styles/colors.dart';

class InputText extends StatefulWidget {
  const InputText(
      {this.hintText = '',
      this.label = '',
      this.labelStyle,
      this.labelMargin,
      required this.onTextChanged,
      this.maxLength,
      this.containerHeight});

  final String hintText;
  final String label;
  final TextStyle? labelStyle;
  final EdgeInsets? labelMargin;
  final int? maxLength;
  final Function(String) onTextChanged;
  final double? containerHeight;

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  String currentText = '';

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
          _label,
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
          widget.label,
          style: widget.labelStyle ??
              GoogleFonts.muli(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: TheoColors.primary,
              ),
        ),
      );

  Widget get _textFormInput => TextFormField(
        maxLines: null,
        minLines: null,
        maxLength: widget.maxLength,
        textAlignVertical: TextAlignVertical.top,
        expands: widget.containerHeight != null,
        onChanged: _onTextChanged,
        decoration: InputDecoration(
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
}