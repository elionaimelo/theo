import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdultContentTag extends StatelessWidget {
  const AdultContentTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            FeatherIcons.eyeOff,
          ),
          Container(
            margin: EdgeInsets.only(right: 8),
          ),
          Text(
            AppLocalizations.of(context)!.adultContentTagText,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
