import 'package:flutter/material.dart';
import 'package:theo/components/option_button.dart';
import 'package:theo/styles/colors.dart';

class QuestionTab extends StatefulWidget {
  QuestionTab({
    Key? key,
    required this.question,
    required this.options,
    required this.onSelectedIndex,
    this.crossAxisAlign = CrossAxisAlignment.center,
    this.questionStyle,
    this.centerOptions = false,
  }) : super(key: key);

  @override
  _QuestionTabState createState() => _QuestionTabState();

  final String question;
  final List<String> options;
  final Function(int index) onSelectedIndex;
  final CrossAxisAlignment crossAxisAlign;
  final TextStyle? questionStyle;
  final bool centerOptions;
}

class _QuestionTabState extends State<QuestionTab> {
  String selectedOption = '';

  void _onOptionButtonTap(String text) {
    if (text == selectedOption) {
      text = '';
    }

    widget.onSelectedIndex(widget.options.indexOf(text));

    setState(() {
      selectedOption = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: widget.crossAxisAlign,
        children: [
          _questionText(widget.question),
          _content,
        ],
      ),
    );
  }

  Widget get _content => widget.centerOptions
      ? Expanded(
          child: _questions,
        )
      : _questions;

  Widget get _questions => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.options
            .map(
              (e) => OptionButton(
                text: e,
                onTap: () => _onOptionButtonTap(e),
                selected: e == selectedOption,
              ),
            )
            .toList(),
      );

  Widget _questionText(String text) => Text(
        text,
        style: widget.questionStyle ??
            Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: TheoColors.seven,
                ),
      );
}
