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
  });

  final String text;
  final IconData? icon;
  final Function? onPressed;
  final Color backgroundColor;
  final Color primaryColor;
  final Color borderColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: primaryColor,
        backgroundColor: backgroundColor,
        textStyle:
            textStyle ?? TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
      ),
      onPressed: () => onPressed?.call(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
