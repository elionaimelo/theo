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
import 'package:theo/validators/file_required_validator.dart';
import 'package:theo/validators/multi_selector_required_validator.dart';
import 'package:theo/validators/text_required_validator.dart';

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
  final _formKey = GlobalKey<FormState>();

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
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _inputs,
                ),
              ),
            ),
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
          validators: [
            TextRequiredValidator(),
          ],
          autoFocus: true,
        ),
        _separator,
        TextInput(
          onTextChanged: widget.controller.onTitleTextChanged,
          label: 'Título',
          hintText: 'Escreva aqui',
          labelStyle: TheoStyles.of(context).labelInputStyle,
          labelMargin: EdgeInsets.only(bottom: 5),
          validators: [
            TextRequiredValidator(),
          ],
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
          validators: [
            TextRequiredValidator(),
          ],
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
              validators: [
                TextRequiredValidator(),
              ],
            ),
          ),
        if (widget.withArchive)
          Container(
            margin: marginLength,
            child: FileInputFormField(
              FileInputFormFieldProps(
                label: 'Arquivo',
                minFileLength: '0',
                onFileSelected: (List<String> paths) =>
                    widget.controller.onArchivePathSelected(paths.first),
                buttonIcon: FeatherIcons.file,
                buttonText: 'Inserir Arquivo',
                assetType: AssetType.other,
                focusNode: FocusNode(),
                validators: [
                  FileRequiredValidator(),
                ],
              ),
            ),
          ),
        if (widget.controller.format.name == StoryFormatConsts.VIDEO)
          Container(
            margin: marginLength,
            child: FileInputFormField(
              FileInputFormFieldProps(
                label: 'Arquivo de Vídeo',
                minFileLength: '0',
                onFileSelected: (List<String> paths) =>
                    widget.controller.onVideoFilePathSelected(paths.first),
                buttonIcon: FeatherIcons.video,
                buttonText: 'Inserir Vídeo',
                assetType: AssetType.video,
                focusNode: FocusNode(),
                validators: [
                  FileRequiredValidator(),
                ],
              ),
            ),
          ),
        _separator,
        _imagesInput,
        _separator,
        MultiSelectorButtonFormField(
          label: 'Conteúdo restrito a maiores de 18 anos?',
          onSelectedValuesChanged: (List<SelectorItem> values) =>
              widget.controller.onContentAgeChanged(values),
          values: [
            SelectorItem(
                key: ObjectKey(true), displayValue: 'Sim', value: true),
            SelectorItem(
                key: ObjectKey(false), displayValue: 'Não', value: false),
          ],
          uniqueSelect: true,
          bold: true,
          focusNode: FocusNode(),
          validators: [
            MultiSelectorRequiredValidator(),
          ],
        ),
        _separator,
        MultiSelectorButtonFormField(
          label: 'Categoria',
          onSelectedValuesChanged:
              widget.controller.onSelectedCategoriesChanged,
          values: widget.controller.storyCategories
              .map(
                (e) => SelectorItem(
                    key: ObjectKey(e), displayValue: e.name!, value: e),
              )
              .toList(),
          uniqueSelect: true,
          bold: false,
          focusNode: FocusNode(),
          validators: [
            MultiSelectorRequiredValidator(),
          ],
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
            onPressed: () {
              FocusScope.of(context).unfocus();
              widget.controller.onPublishButtonTap(_formKey.currentState!);
            },
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

  Widget get _imagesInput => _multiplesImages
      ? FileInputFormField(FileInputFormFieldProps(
          label: 'Disponibilize algumas imagens',
          minFileLength: '0',
          onFileSelected: widget.controller.onImagesPathsSelected,
          buttonIcon: FeatherIcons.image,
          buttonText: 'Inserir Imagem',
          assetType: AssetType.image,
          multipleFiles: _multiplesImages,
          focusNode: FocusNode(),
          validators: [
            FileRequiredValidator(),
          ],
        ))
      : FileInputFormField(FileInputFormFieldProps(
          label: 'Imagem de Capa (Opcional)',
          minFileLength: '0',
          onFileSelected: widget.controller.onImagesPathsSelected,
          buttonIcon: FeatherIcons.image,
          buttonText: 'Inserir Imagem',
          assetType: AssetType.image,
          multipleFiles: _multiplesImages,
          focusNode: FocusNode(),
          validators: [
            FileRequiredValidator(),
          ],
        ));

  bool get _multiplesImages {
    switch (widget.controller.format.name) {
      case StoryFormatConsts.GAME:
        return true;
      default:
        return false;
    }
  }
}
