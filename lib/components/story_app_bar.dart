import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/close_top_bar_button.dart';
import 'package:theo/components/text_icon_button.dart';
import 'package:theo/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoryAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CloseTopBarButton(foregroundColor: TheoColors.primary),
          TextIconButton(
            onTap: () {},
            text: AppLocalizations.of(context)!.save,
            foregroundColor: TheoColors.seven,
            direction: TextDirection.rtl,
            icon: Icon(
              FeatherIcons.bookmark,
              color: TheoColors.seven,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
