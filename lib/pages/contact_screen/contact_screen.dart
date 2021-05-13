import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/inputs/file_input.dart';
import 'package:theo/components/inputs/text_input.dart';
import 'package:theo/components/title_text.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/gerenal.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  void _onNameTextChanged(String value) {}

  void _onEmailTextChanged(String value) {}

  void _onPublishButtonTap() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 27),
            ),
            TitleText(
              title: 'Contato',
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
            ),
            TextInput(
              onTextChanged: _onNameTextChanged,
              label: 'Nome',
              labelStyle: TheoStyles.of(context).labelInputStyle,
              hintText: 'Escreva aqui',
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
            ),
            TextInput(
              onTextChanged: _onEmailTextChanged,
              label: 'Email',
              labelStyle: TheoStyles.of(context).labelInputStyle,
              hintText: 'Escreva aqui',
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
            ),
            TextInput(
              onTextChanged: _onEmailTextChanged,
              label: 'Mensagem',
              labelStyle: TheoStyles.of(context).labelInputStyle,
              hintText: 'Escreva aqui sua mensagem',
              containerHeight: 246,
              maxLength: 450,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            FileInput(
              label: '',
              minFileLength: '0',
              buttonText: 'Inserir Arquivo',
              buttonIcon: FeatherIcons.file,
              fileType: EFileType.OTHER,
            ),
            Container(
              margin: EdgeInsets.only(top: 36),
            ),
            BottomButton(
              onPressed: _onPublishButtonTap,
              backgroundColor: TheoColors.secondary,
              primaryColor: TheoColors.primary,
              text: 'Enviar',
              textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
              borderColor: TheoColors.primary,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
            ),
          ],
        ),
      ),
    );
  }
}
