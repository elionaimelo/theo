import 'package:flutter/material.dart';
import 'package:theo/styles/colors.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    this.text = '',
    this.icon,
    this.onPressed,
    this.primaryColor = TheoColors.secondary,
    this.backgroundColor = TheoColors.primary,
    this.textStyle,
    this.borderColor = Colors.transparent,
    this.textDirection = TextDirection.ltr,
    this.borderWidth = 2,
  });

  final String text;
  final IconData? icon;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color primaryColor;
  final Color borderColor;
  final double borderWidth;
  final TextStyle? textStyle;
  final TextDirection textDirection;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: primaryColor,
        backgroundColor: backgroundColor,
        textStyle: textStyle ??
            TextStyle(
                fontSize: 18, fontWeight: FontWeight.w900, color: primaryColor),
        onSurface: primaryColor,
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: textDirection,
          children: [
            Text(
              text,
            ),
            if (icon != null)
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Icon(
                  icon,
                  color: primaryColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
