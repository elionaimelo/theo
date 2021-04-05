import 'package:flutter/material.dart';
import 'package:theo/constant.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    this.text = '',
    this.icon,
    this.onPressed,
    this.primaryColor = Colors.white,
    this.backgroundColor = kprimaryColor,
  });

  final String text;
  final IconData icon;
  final Function onPressed;
  final Color backgroundColor;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          primary: primaryColor,
          backgroundColor: backgroundColor,
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
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
                  color: Colors.white,
                ),
              )
          ],
        ),
      ),
    );
  }
}
