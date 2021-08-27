import 'package:flutter/material.dart';
import 'package:theo/components/question_tab.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({
    Key? key,
    required this.item,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  final OptionItem item;
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item.icon != null)
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: item.icon!,
                ),
              Text(
                item.text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: TheoColors.seven,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double get _cardElevation => selected ? 0 : TheoMetrics.cardElevation;

  Color get _color => selected ? TheoColors.twentyNine : Colors.transparent;
}
