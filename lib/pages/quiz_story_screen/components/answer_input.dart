import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/checked_icon.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

enum EAnswerInputState { SUCCESS, ERROR, SELECTED, NONE }

class AnswerInput extends StatefulWidget {
  const AnswerInput({
    Key? key,
    required this.onTapSuccess,
    required this.onTapAnswer,
    required this.eAnswerInputState,
    required this.onTapCorrect,
    required this.onTapJump,
  }) : super(key: key);

  final EAnswerInputState eAnswerInputState;
  final Function() onTapSuccess;
  final Function() onTapAnswer;
  final Function() onTapCorrect;
  final Function() onTapJump;

  @override
  _AnswerInputState createState() => _AnswerInputState();
}

class _AnswerInputState extends State<AnswerInput> {
  EdgeInsets get _padding => TheoMetrics.paddingScreen.copyWith(top: 15);
  @override
  Widget build(BuildContext context) {
    if (widget.eAnswerInputState == EAnswerInputState.SELECTED ||
        widget.eAnswerInputState == EAnswerInputState.NONE) return _selected;

    if (widget.eAnswerInputState == EAnswerInputState.SUCCESS) return _success;

    if (widget.eAnswerInputState == EAnswerInputState.ERROR) return _error;

    return Container();
  }

  Widget get _success => Container(
        padding: _padding,
        color: TheoColors.thirty,
        child: Column(
          children: [
            Row(
              children: [
                CheckedIcon(),
                Container(
                  margin: EdgeInsets.only(left: 7),
                ),
                Text(
                  'Bom trabalho!',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: TheoColors.twenty,
                      ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            BottomButton(
              onPressed: widget.onTapSuccess,
              backgroundColor: TheoColors.twenty,
              text: 'Continuar',
              icon: FeatherIcons.arrowRight,
            ),
          ],
        ),
      );

  Widget get _error => Container(
        padding: _padding,
        color: TheoColors.thirty,
        child: Column(
          children: [
            Row(
              children: [
                CheckedIcon(),
                Container(
                  margin: EdgeInsets.only(left: 7),
                ),
                Text(
                  'Errado!',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: TheoColors.thirtyOne,
                      ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Row(
              children: [
                _jumpButton,
                Container(
                  margin: EdgeInsets.only(left: 5),
                ),
                _correctButton,
              ],
            ),
          ],
        ),
      );

  Widget get _selected => Container(
        padding: _padding,
        child: Row(
          children: [
            _jumpButton,
            Container(
              margin: EdgeInsets.only(left: 5),
            ),
            _answerButton,
          ],
        ),
      );

  Widget get _jumpButton => Flexible(
        child: BottomButton(
          onPressed: widget.onTapJump,
          text: 'Pular',
          backgroundColor: Colors.transparent,
          borderColor: TheoColors.primary,
          primaryColor: TheoColors.primary,
          borderWidth: 1,
          textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
        ),
      );

  Widget get _answerButton => Flexible(
        flex: 3,
        child: BottomButton(
          onPressed: widget.eAnswerInputState == EAnswerInputState.SELECTED
              ? widget.onTapAnswer
              : null,
          text: 'Verificar',
          backgroundColor:
              widget.eAnswerInputState == EAnswerInputState.SELECTED
                  ? TheoColors.primary
                  : TheoColors.twentyEight,
          primaryColor: TheoColors.secondary,
          textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: TheoColors.secondary,
              ),
        ),
      );

  Widget get _correctButton => Flexible(
        flex: 3,
        child: BottomButton(
          onPressed: widget.onTapCorrect,
          text: 'Corrigir',
          backgroundColor: TheoColors.thirtyOne,
          primaryColor: TheoColors.secondary,
          textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: TheoColors.secondary,
              ),
        ),
      );
}
