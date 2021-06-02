import 'package:flutter/material.dart';
import 'package:theo/pages/quiz_story_screen/components/option_button.dart';
import 'package:theo/styles/colors.dart';

class QuestionTab extends StatefulWidget {
  const QuestionTab({
    Key? key,
    required this.question,
    required this.options,
    required this.onSelectedIndex,
  }) : super(key: key);

  @override
  _QuestionTabState createState() => _QuestionTabState();

  final String question;
  final List<String> options;
  final Function(int index) onSelectedIndex;
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
        children: [
          _questionText(widget.question),
          Expanded(
            child: Container(
              child: Column(
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _questionText(String text) => Text(
        text,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: TheoColors.seven,
            ),
      );
}
