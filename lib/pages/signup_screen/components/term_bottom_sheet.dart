import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermBottomSheet extends StatelessWidget {
  const TermBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: TheoMetrics.appBarHeight + 30),
      child: Card(
        color: TheoColors.secondary,
        margin: EdgeInsets.zero,
        elevation: TheoMetrics.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: TheoMetrics.paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.termTabTitle,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                      color: TheoColors.seven,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: ListView(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.term,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 16,
                              color: TheoColors.seven,
                            ),
                      )
                    ],
                  ),
                ),
              ),
              BottomButton(
                text: AppLocalizations.of(context)!.close,
                icon: FeatherIcons.x,
                backgroundColor: TheoColors.secondary,
                primaryColor: TheoColors.primary,
                borderColor: TheoColors.primary,
                onPressed: () => Navigator.of(context).pop(),
                textDirection: TextDirection.rtl,
              )
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> showTermBottomSheet(BuildContext context) async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return TermBottomSheet();
      },
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
    );
  }
}
