import 'package:flutter/material.dart';
import 'package:theo/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextIconButton extends StatelessWidget {
  TextIconButton({
    this.foregroundColor = TheoColors.primary,
    this.text,
    this.direction = TextDirection.ltr,
    required this.onTap,
    this.icon,
    this.textStyle,
    this.innerPadding,
  });

  final Color foregroundColor;
  final String? text;
  final TextDirection direction;
  final Function onTap;
  final Widget? icon;
  final TextStyle? textStyle;
  final EdgeInsets? innerPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: innerPadding ?? EdgeInsets.all(3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: direction,
          children: [
            if (icon != null) icon!,
            Text(
              text ?? AppLocalizations.of(context)!.cancel,
              style: textStyle ??
                  Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14,
                        color: foregroundColor,
                      ),
            )
          ],
        ),
      ),
    );
  }
}
