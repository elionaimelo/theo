import 'package:flutter/material.dart';
import 'package:theo/components/gallery_image_picker.dart';
import 'package:theo/components/image_input.dart';
import 'package:theo/components/text_input.dart';
import 'package:theo/components/text_selector.dart';
import 'package:theo/components/titleText.dart';
import 'package:theo/components/multi_selector_button_input.dart';
import 'package:theo/styles/colors.dart';

class NewTellScreenArgs {
  NewTellScreenArgs({required this.title});
  final String title;
}

class NewTellScreen extends StatefulWidget {
  NewTellScreen({required this.args});

  final NewTellScreenArgs args;

  String get title => args.title;

  @override
  _NewTellScreenState createState() => _NewTellScreenState();
}

class _NewTellScreenState extends State<NewTellScreen> {
  void _onTitleTextChanged(String value) {}

  void _onLangSelectionChanged(String? value) {}

  List<SelectorItem> _categoryItems = [
    SelectorItem(displayValue: 'Ciência'),
    SelectorItem(displayValue: 'Sífilis'),
    SelectorItem(displayValue: 'Saúde'),
    SelectorItem(displayValue: 'Tecnologia'),
    SelectorItem(displayValue: 'Meio ambiente'),
    SelectorItem(displayValue: 'Matemática'),
    SelectorItem(displayValue: 'Inovação'),
    SelectorItem(displayValue: 'Artes'),
    SelectorItem(displayValue: 'História'),
    SelectorItem(displayValue: 'Linguística'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: ListView(
            children: [
              TitleText(
                title: widget.title,
              ),
              TextSelector(
                items: ['Português', 'Inglês'],
                onSelectionChanged: _onLangSelectionChanged,
                label: 'Idioma padrão',
              ),
              InputText(
                onTextChanged: _onTitleTextChanged,
                label: 'Título',
                hintText: 'Escreva aqui',
                labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                labelMargin: EdgeInsets.only(bottom: 5),
              ),
              InputText(
                onTextChanged: _onTitleTextChanged,
                label: 'Breve descrição (opcional)',
                hintText: 'Escreva aqui',
                maxLength: 125,
                containerHeight: 110,
                labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: TheoColors.seven,
                    ),
                labelMargin: EdgeInsets.only(bottom: 5),
              ),
              InputText(
                onTextChanged: _onTitleTextChanged,
                label: 'Autor',
                hintText: 'Escreva aqui',
                labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: TheoColors.seven,
                    ),
                labelMargin: EdgeInsets.only(bottom: 5),
              ),
              InputText(
                onTextChanged: _onTitleTextChanged,
                label: 'Inserir link do video',
                hintText: 'Escreva aqui',
                labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: TheoColors.seven,
                    ),
                labelMargin: EdgeInsets.only(bottom: 5),
              ),
              ImageInput(
                label: 'Imagem de Capa (Opcional)',
                minImageLength: '0',
              ),
              MultiSelectorButtonInput(
                label: 'Conteúdo restrito a maiores de 18 anos?',
                onSelectedValuesChanged: (List<SelectorItem> values) {},
                values: [
                  SelectorItem(displayValue: 'Sim', value: true),
                  SelectorItem(displayValue: 'Não', value: false),
                ],
                uniqueSelect: true,
                bold: true,
              ),
              MultiSelectorButtonInput(
                label: 'Categoria da animação',
                onSelectedValuesChanged: (List<SelectorItem> values) {},
                values: _categoryItems,
                uniqueSelect: false,
                bold: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
