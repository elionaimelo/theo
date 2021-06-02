import 'package:flutter/material.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  final String text;
  final Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: _cardElevation,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: _color,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: TheoColors.seven,
                ),
          ),
        ),
      ),
    );
  }

  double get _cardElevation => selected ? 0 : TheoMetrics.cardElevation;

  Color get _color => selected ? TheoColors.twentyNine : Colors.transparent;
}
