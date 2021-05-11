import 'package:flutter/material.dart';
import 'package:theo/components/line_text_button.dart';
import 'package:theo/styles/colors.dart';

class ProfileAction extends StatelessWidget {
  const ProfileAction({
    Key? key,
    this.icon,
    this.text,
    this.sufixButton,
    this.onCardTap,
  }) : super(key: key);

  final IconData? icon;
  final String? text;
  final LineTextButton? sufixButton;
  final Function()? onCardTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: TheoColors.seventeen,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: Row(
            children: [
              if (icon != null) _icon,
              if (text != null) _text(context),
              if (sufixButton != null) _sufixButton,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _icon => Container(
        margin: EdgeInsets.only(right: 8),
        child: Icon(
          icon,
          color: TheoColors.primary,
        ),
      );

  Widget _text(BuildContext context) => Text(
        text!,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 16,
              color: TheoColors.twentyTwo,
            ),
      );

  Widget get _sufixButton => Expanded(
        child: Container(
          alignment: Alignment.centerRight,
          child: sufixButton!,
        ),
      );
}
