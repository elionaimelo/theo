import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:theo/components/alert_message.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/inputs/gallery_image_picker.dart';
import 'package:theo/components/inputs/file_input.dart';
import 'package:theo/components/inputs/text_input.dart';
import 'package:theo/components/inputs/text_selector_input.dart';
import 'package:theo/components/titleText.dart';
import 'package:theo/components/inputs/multi_selector_button_input.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/gerenal.dart';

class NewTellScreenArgs {
  NewTellScreenArgs({
    required this.title,
    this.withLink = false,
    this.withArchive = false,
  });
  final String title;
  final bool withLink;
  final bool withArchive;
}

class NewTellScreen extends StatefulWidget {
  NewTellScreen({required this.args});

  final NewTellScreenArgs args;

  String get title => args.title;
  bool get withLink => args.withLink;
  bool get withArchive => args.withArchive;

  @override
  _NewTellScreenState createState() => _NewTellScreenState();
}

class _NewTellScreenState extends State<NewTellScreen> {
  void _onTitleTextChanged(String value) {}

  void _onDescTextChanged(String value) {}

  void _onAuthorTextChanged(String value) {}

  void _onLinkTextChanged(String value) {}

  void _onLangSelectionChanged(String? value) {}

  void _onImageSelected(AssetEntity value) {}

  void _onContentAgeChanged(SelectorItem value) {}

  void _onSelectedCategoriesChanged(List<SelectorItem> values) {}

  void _onKeyword1TextChanged(String value) {}
  void _onKeyword2TextChanged(String value) {}
  void _onKeyword3TextChanged(String value) {}

  void _onPublishButtonTap() {
    Navigator.of(context).pop();
  }

  final List<SelectorItem> _categoryItems = [
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
              TextSelectorInput(
                items: ['Português', 'Inglês'],
                onSelectionChanged: _onLangSelectionChanged,
                label: 'Idioma padrão',
              ),
              TextInput(
                onTextChanged: _onTitleTextChanged,
                label: 'Título',
                hintText: 'Escreva aqui',
                labelStyle: TheoStyles.of(context).labelInputStyle,
                labelMargin: EdgeInsets.only(bottom: 5),
              ),
              TextInput(
                onTextChanged: _onDescTextChanged,
                label: 'Breve descrição (opcional)',
                hintText: 'Escreva aqui',
                maxLength: 125,
                containerHeight: 110,
                labelStyle: TheoStyles.of(context).labelInputStyle,
                labelMargin: EdgeInsets.only(bottom: 5),
              ),
              TextInput(
                onTextChanged: _onAuthorTextChanged,
                label: 'Autor',
                hintText: 'Escreva aqui',
                labelStyle: TheoStyles.of(context).labelInputStyle,
                labelMargin: EdgeInsets.only(bottom: 5),
              ),
              if (widget.withLink)
                TextInput(
                  onTextChanged: _onLinkTextChanged,
                  label: 'Inserir link',
                  hintText: 'Escreva aqui',
                  labelStyle: TheoStyles.of(context).labelInputStyle,
                  labelMargin: EdgeInsets.only(bottom: 5),
                ),
              if (widget.withArchive)
                FileInput(
                  label: 'Arquivo',
                  minFileLength: '0',
                  onImageSelected: _onImageSelected,
                  buttonIcon: FeatherIcons.file,
                  buttonText: 'Inserir Arquivo',
                  fileType: EFileType.OTHER,
                ),
              FileInput(
                label: 'Imagem de Capa (Opcional)',
                minFileLength: '0',
                onImageSelected: _onImageSelected,
                buttonIcon: FeatherIcons.image,
                buttonText: 'Inserir Imagem',
                fileType: EFileType.IMAGE,
              ),
              MultiSelectorButtonInput(
                label: 'Conteúdo restrito a maiores de 18 anos?',
                onSelectedValuesChanged: (List<SelectorItem> values) =>
                    _onContentAgeChanged(values.single),
                values: [
                  SelectorItem(displayValue: 'Sim', value: true),
                  SelectorItem(displayValue: 'Não', value: false),
                ],
                uniqueSelect: true,
                bold: true,
              ),
              MultiSelectorButtonInput(
                label: 'Categoria',
                onSelectedValuesChanged: _onSelectedCategoriesChanged,
                values: _categoryItems,
                uniqueSelect: false,
                bold: false,
              ),
              Container(
                margin: EdgeInsets.only(top: 9),
              ),
              TextInput(
                onTextChanged: _onKeyword1TextChanged,
                label: 'Inserir link do video',
                hintText: 'Palavra-chave 1 aqui',
                labelStyle: TheoStyles.of(context).labelInputStyle,
                labelMargin: EdgeInsets.only(bottom: 5),
              ),
              Container(
                margin: EdgeInsets.only(top: 9),
              ),
              TextInput(
                onTextChanged: _onKeyword2TextChanged,
                hintText: 'Palavra-chave 2 aqui',
                labelStyle: TheoStyles.of(context).labelInputStyle,
                labelMargin: EdgeInsets.only(bottom: 5),
              ),
              Container(
                margin: EdgeInsets.only(top: 9),
              ),
              TextInput(
                onTextChanged: _onKeyword3TextChanged,
                hintText: 'Palavra-chave 3 aqui',
                labelStyle: TheoStyles.of(context).labelInputStyle,
                labelMargin: EdgeInsets.only(bottom: 5),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: AlertMessage(
                  text:
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita',
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50, bottom: 10),
                child: BottomButton(
                  onPressed: _onPublishButtonTap,
                  backgroundColor: TheoColors.secondary,
                  primaryColor: TheoColors.primary,
                  text: 'Publicar',
                  textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                  borderColor: TheoColors.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
