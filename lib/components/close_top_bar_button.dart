import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/text_icon_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CloseTopBarButton extends StatelessWidget {
  const CloseTopBarButton({
    Key? key,
    required this.foregroundColor,
    this.size = 35,
    this.textSize = 16,
  }) : super(key: key);

  final Color foregroundColor;
  final double size;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return TextIconButton(
      onTap: () => Navigator.of(context).pop(),
      foregroundColor: foregroundColor,
      textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: textSize,
            color: foregroundColor,
          ),
      text: AppLocalizations.of(context)!.close,
      icon: Icon(
        FeatherIcons.x,
        color: foregroundColor,
        size: size,
      ),
    );
  }
}
