import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/inputs/multi_selector_button_input.dart';
import 'package:theo/components/inputs/text_input.dart';
import 'package:theo/components/subTitleText.dart';
import 'package:theo/components/title_text.dart';

import 'package:theo/mocks/theo_mocks.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  AppLocalizations get _locale => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TheoMetrics.paddingScreen,
      child: ListView(
        children: [
          TitleText(
            title: _locale.searchPageTitle,
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
          ),
          TextInput(
            onTextChanged: (String value) {},
            hintText: _locale.searchInputHint,
            prefixWidget: Icon(
              FeatherIcons.search,
              color: TheoColors.eighteen,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
          ),
          TitleText(
            title: _locale.explore,
          ),
          SubTitleText(
            subTitle: _locale.exploreSubtitle,
          ),
          Container(
            margin: EdgeInsets.only(top: 23),
          ),
          MultiSelectorButtonFormField(
            label: _locale.categories,
            values: TheoMocks.categoriesMock
                .map((e) => SelectorItem(key: ObjectKey(e), displayValue: e))
                .toList(),
            onSelectedValuesChanged: (_) {},
            focusNode: FocusNode(),
          ),
          Container(
            margin: EdgeInsets.only(top: 34),
          ),
          MultiSelectorButtonFormField(
            label: _locale.formats,
            values: TheoMocks.tellFormatsMock
                .map((e) => SelectorItem(key: ObjectKey(e), displayValue: e))
                .toList(),
            onSelectedValuesChanged: (_) {},
            primaryColor: TheoColors.nineteen,
            focusNode: FocusNode(),
          ),
          Container(
            margin: EdgeInsets.only(top: 34),
          ),
          MultiSelectorButtonFormField(
            label: _locale.languages,
            values: TheoMocks.languagesMock
                .map((e) => SelectorItem(key: ObjectKey(e), displayValue: e))
                .toList(),
            onSelectedValuesChanged: (_) {},
            primaryColor: TheoColors.twenty,
            focusNode: FocusNode(),
          ),
          Container(
            margin: EdgeInsets.only(top: 34),
          ),
          BottomButton(
            onPressed: () {},
            backgroundColor: TheoColors.secondary,
            primaryColor: TheoColors.primary,
            text: _locale.search,
            textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
            borderColor: TheoColors.primary,
          ),
        ],
      ),
    );
  }
}
