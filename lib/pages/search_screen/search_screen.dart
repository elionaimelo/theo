import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/inputs/multi_selector_button_input.dart';
import 'package:theo/components/inputs/text_input.dart';
import 'package:theo/components/subTitleText.dart';
import 'package:theo/components/titleText.dart';

import 'package:theo/models/theo_mocks.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TheoMetrics.paddingScreen,
      child: ListView(
        children: [
          TitleText(
            title: 'Pesquisar',
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
          ),
          TextInput(
            onTextChanged: (String value) {},
            hintText: 'Busque aqui',
            prefixWidget: Icon(
              FeatherIcons.search,
              color: TheoColors.eighteen,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
          ),
          TitleText(
            title: 'Explorar',
          ),
          SubTitleText(
            subTitle: 'Selecione os tópicos que deseja encontrar',
          ),
          Container(
            margin: EdgeInsets.only(top: 23),
          ),
          MultiSelectorButtonInput(
            label: 'Categorias',
            values: TheoMocks.categoriesMock
                .map((e) => SelectorItem(displayValue: e))
                .toList(),
            onSelectedValuesChanged: (_) {},
          ),
          Container(
            margin: EdgeInsets.only(top: 34),
          ),
          MultiSelectorButtonInput(
            label: 'Formatos',
            values: TheoMocks.tellFormatsMock
                .map((e) => SelectorItem(displayValue: e))
                .toList(),
            onSelectedValuesChanged: (_) {},
            primaryColor: TheoColors.nineteen,
          ),
          Container(
            margin: EdgeInsets.only(top: 34),
          ),
          MultiSelectorButtonInput(
            label: 'Idiomas',
            values: TheoMocks.languagesMock
                .map((e) => SelectorItem(displayValue: e))
                .toList(),
            onSelectedValuesChanged: (_) {},
            primaryColor: TheoColors.twenty,
          ),
          Container(
            margin: EdgeInsets.only(top: 34),
          ),
          BottomButton(
            onPressed: () {},
            backgroundColor: TheoColors.secondary,
            primaryColor: TheoColors.primary,
            text: 'Buscar',
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
