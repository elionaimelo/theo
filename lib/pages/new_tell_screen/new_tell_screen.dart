import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:theo/components/alert_message.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/components/inputs/file_input.dart';
import 'package:theo/components/inputs/text_input.dart';
import 'package:theo/components/inputs/text_selector_input.dart';
import 'package:theo/components/result_status/loading_status.dart';
import 'package:theo/components/title_text.dart';
import 'package:theo/components/inputs/multi_selector_button_input.dart';
import 'package:theo/core/constants/story_format_consts.dart';
import 'package:theo/pages/new_tell_screen/new_tell_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/gerenal.dart';
import 'package:theo/types/enums.dart';

class NewTellScreen extends StatefulWidget {
  NewTellScreen({required this.controller});

  final NewTellScreenController controller;

  String get pagTitle => controller.format.displayName;
  bool get withLink => controller.withLink;
  bool get withArchive => controller.withArchive;

  @override
  _NewTellScreenState createState() => _NewTellScreenState();
}

class _NewTellScreenState extends State<NewTellScreen> {
  @override
  void initState() {
    super.initState();

    widget.controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (widget.controller.eResultStatus == EResultStatus.LOADING) {
          return LoadingStatus();
        } else if (widget.controller.eResultStatus ==
            EResultStatus.REQUEST_ERROR) {
          return ErrorAlertDialog(content: widget.controller.errorMessage!);
        }

        return _content;
      },
    );
  }

  Widget get _content => SafeArea(
        child: Container(
          color: TheoColors.secondary,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                child: SingleChildScrollView(
              child: Column(
                children: _inputs,
              ),
            )),
          ),
        ),
      );

  EdgeInsets marginLength = EdgeInsets.only(top: 20);

  Widget get _separator => Container(
        margin: marginLength,
      );

  List<Widget> get _inputs => <Widget>[
        TitleText(
          title: widget.pagTitle,
        ),
        _separator,
        TextSelectorInput(
          items:
              widget.controller.languages.map((e) => e.displayName!).toList(),
          onSelectionChanged: widget.controller.onLangSelectionChanged,
          label: 'Idioma padrão',
        ),
        _separator,
        TextInput(
          onTextChanged: widget.controller.onTitleTextChanged,
          label: 'Título',
          hintText: 'Escreva aqui',
          labelStyle: TheoStyles.of(context).labelInputStyle,
          labelMargin: EdgeInsets.only(bottom: 5),
        ),
        _separator,
        TextInput(
          onTextChanged: widget.controller.onDescTextChanged,
          label: 'Breve descrição (opcional)',
          hintText: 'Escreva aqui',
          maxLength: 125,
          containerHeight: 110,
          labelStyle: TheoStyles.of(context).labelInputStyle,
          labelMargin: EdgeInsets.only(bottom: 5),
        ),
        _separator,
        TextInput(
          onTextChanged: widget.controller.onAuthorTextChanged,
          label: 'Autor',
          hintText: 'Escreva aqui',
          labelStyle: TheoStyles.of(context).labelInputStyle,
          labelMargin: EdgeInsets.only(bottom: 5),
        ),
        if (widget.withLink)
          Container(
            margin: marginLength,
            child: TextInput(
              onTextChanged: widget.controller.onLinkTextChanged,
              label: 'Inserir link',
              hintText: 'Escreva aqui',
              labelStyle: TheoStyles.of(context).labelInputStyle,
              labelMargin: EdgeInsets.only(bottom: 5),
            ),
          ),
        if (widget.withArchive)
          Container(
            margin: marginLength,
            child: FileInput(
              label: 'Arquivo',
              minFileLength: '0',
              onFileSelected: widget.controller.onArchivePathSelected,
              buttonIcon: FeatherIcons.file,
              buttonText: 'Inserir Arquivo',
              assetType: AssetType.other,
            ),
          ),
        if (widget.controller.format.name == StoryFormatConsts.VIDEO)
          Container(
            margin: marginLength,
            child: FileInput(
              label: 'Arquivo de Vídeo',
              minFileLength: '0',
              onFileSelected: widget.controller.onVideoFilePathSelected,
              buttonIcon: FeatherIcons.video,
              buttonText: 'Inserir Vídeo',
              assetType: AssetType.video,
            ),
          ),
        _separator,
        FileInput(
          label: 'Imagem de Capa (Opcional)',
          minFileLength: '0',
          onFileSelected: widget.controller.onImagesPathsSelected,
          buttonIcon: FeatherIcons.image,
          buttonText: 'Inserir Imagem',
          assetType: AssetType.image,
        ),
        _separator,
        MultiSelectorButtonInput(
          label: 'Conteúdo restrito a maiores de 18 anos?',
          onSelectedValuesChanged: (List<SelectorItem> values) =>
              widget.controller.onContentAgeChanged(values.single),
          values: [
            SelectorItem(displayValue: 'Sim', value: true),
            SelectorItem(displayValue: 'Não', value: false),
          ],
          uniqueSelect: true,
          bold: true,
        ),
        _separator,
        MultiSelectorButtonInput(
          label: 'Categoria',
          onSelectedValuesChanged:
              widget.controller.onSelectedCategoriesChanged,
          values: widget.controller.storyCategories
              .map((e) => SelectorItem(displayValue: e.name!, value: e))
              .toList(),
          uniqueSelect: true,
          bold: false,
        ),
        _separator,
        Column(
          children: [
            TextInput(
              onTextChanged: widget.controller.onKeyword1TextChanged,
              label: 'Palavras-chave',
              hintText: 'Palavra-chave 1 aqui',
              labelStyle: TheoStyles.of(context).labelInputStyle,
              labelMargin: EdgeInsets.only(bottom: 5),
            ),
            Container(
              margin: EdgeInsets.only(top: 9),
            ),
            TextInput(
              onTextChanged: widget.controller.onKeyword2TextChanged,
              hintText: 'Palavra-chave 2 aqui',
              labelStyle: TheoStyles.of(context).labelInputStyle,
              labelMargin: EdgeInsets.only(bottom: 5),
            ),
            Container(
              margin: EdgeInsets.only(top: 9),
            ),
            TextInput(
              onTextChanged: widget.controller.onKeyword3TextChanged,
              hintText: 'Palavra-chave 3 aqui',
              labelStyle: TheoStyles.of(context).labelInputStyle,
              labelMargin: EdgeInsets.only(bottom: 5),
            ),
          ],
        ),
        _separator,
        Container(
          margin: EdgeInsets.only(top: 25),
          child: AlertMessage(
            text:
                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita',
          ),
        ),
        _separator,
        Container(
          margin: EdgeInsets.only(top: 50, bottom: 10),
          child: BottomButton(
            onPressed: widget.controller.onPublishButtonTap,
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
      ];
}
