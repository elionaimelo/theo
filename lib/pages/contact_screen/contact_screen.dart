import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/inputs/file_input.dart';
import 'package:theo/components/inputs/text_input.dart';
import 'package:theo/components/title_text.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/gerenal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  AppLocalizations get _locale => AppLocalizations.of(context)!;

  void _onNameTextChanged(String value) {}

  void _onEmailTextChanged(String value) {}

  void _onPublishButtonTap() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TheoColors.secondary,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 27),
            ),
            TitleText(
              title: _locale.contactTitle,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
            ),
            TextInput(
              onTextChanged: _onNameTextChanged,
              label: _locale.contactName,
              labelStyle: TheoStyles.of(context).labelInputStyle,
              hintText: _locale.defaultInputHint,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
            ),
            TextInput(
              onTextChanged: _onEmailTextChanged,
              label: _locale.contactEmail,
              labelStyle: TheoStyles.of(context).labelInputStyle,
              hintText: _locale.defaultInputHint,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
            ),
            TextInput(
              onTextChanged: _onEmailTextChanged,
              label: _locale.contactMessage,
              labelStyle: TheoStyles.of(context).labelInputStyle,
              hintText: _locale.contactMessageInputHint,
              containerHeight: 246,
              maxLength: 450,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            FileInputFormField(
              FileInputFormFieldProps(
                label: '',
                minFileLength: '0',
                onFileSelected: (List<String> value) {},
                buttonText: _locale.insertFile,
                buttonIcon: FeatherIcons.file,
                assetType: AssetType.other,
                focusNode: FocusNode(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 36),
            ),
            BottomButton(
              onPressed: _onPublishButtonTap,
              backgroundColor: TheoColors.secondary,
              primaryColor: TheoColors.primary,
              text: _locale.send,
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
