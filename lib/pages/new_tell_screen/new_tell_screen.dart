import 'package:flutter/material.dart';
import 'package:theo/components/text_input.dart';
import 'package:theo/components/text_selector.dart';
import 'package:theo/components/titleText.dart';
import 'package:theo/styles/colors.dart';

class NewTellScreen extends StatefulWidget {
  NewTellScreen({required this.title});

  @override
  _NewTellScreenState createState() => _NewTellScreenState();

  final String title;
}

class _NewTellScreenState extends State<NewTellScreen> {
  void _onTitleTextChanged(String value) {}

  void _onLangSelectionChanged(String? value) {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
            ],
          ),
        ),
      ),
    );
  }
}
