import 'package:flutter/material.dart';
import 'package:theo/styles/colors.dart';

class LineTextButton extends StatefulWidget {
  const LineTextButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.textStyle,
  }) : super(key: key);

  @override
  _LineTextButtonState createState() => _LineTextButtonState();

  final String text;
  final Function onTap;
  final TextStyle? textStyle;
}

class _LineTextButtonState extends State<LineTextButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        child: Text(
          widget.text,
          style: widget.textStyle ??
              Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14,
                    color: TheoColors.primary,
                  ),
        ),
      ),
    );
  }
}
