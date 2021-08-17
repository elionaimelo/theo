import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/line_text_button.dart';
import 'package:theo/components/subTitleText.dart';
import 'package:theo/components/title_text.dart';
import 'package:theo/pages/profile_screen/components/profile_action.dart';
import 'package:theo/pages/profile_screen/components/profile_data_field.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notification = false;

  AppLocalizations get _locale => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TheoMetrics.paddingScreen,
      child: ListView(
        children: [
          TitleText(
            title: _locale.profilePageTitle,
          ),
          SubTitleText(
            subTitle: _locale.profilePageSubtitle,
          ),
          _profileImage,
          Container(
            margin: EdgeInsets.only(top: 23),
          ),
          _profileData,
          _profileActions,
        ],
      ),
    );
  }

  Widget get _profileImage => Container(
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/avataaars.jpg',
                ),
              ),
            ),
            LineTextButton(
              text: _locale.profileInputImage,
              onTap: () {},
            ),
          ],
        ),
      );

  Widget get _profileData => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: TheoColors.seventeen,
        ),
        padding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
        child: Column(
          children: [
            Material(
              type: MaterialType.transparency,
              child: ProfileDataField(
                textLabel: _locale.profileNameLabel,
                textValue: 'Nome do usuário',
                onTap: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
            ),
            Material(
              type: MaterialType.transparency,
              child: ProfileDataField(
                textLabel: _locale.profileEmailLabel,
                textValue: 'email-n@gmail.com',
                onTap: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
            ),
            Material(
              type: MaterialType.transparency,
              child: ProfileDataField(
                textLabel: _locale.profilePasswordLabel,
                textValue: 'password',
                onTap: () {},
                obscureText: true,
              ),
            )
          ],
        ),
      );

  Widget get _profileActions => Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            ProfileAction(
              icon: FeatherIcons.bell,
              text: _locale.profileNotification,
              sufixButton: notification ? desactiveButton : activateButton,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            ProfileAction(
              icon: FeatherIcons.xCircle,
              text: _locale.accountManager,
              sufixButton: LineTextButton(
                text: 'selecionar',
                onTap: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            ProfileAction(
              icon: FeatherIcons.bookmark,
              text: _locale.savedStories,
              sufixButton: LineTextButton(
                text: 'ver mais',
                onTap: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            ProfileAction(
              icon: FeatherIcons.clock,
              text: _locale.postHistory,
              sufixButton: LineTextButton(
                text: _locale.seeMore,
                onTap: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            ProfileAction(
              icon: FeatherIcons.messageSquare,
              text: _locale.shareStory,
              sufixButton: LineTextButton(
                text: _locale.seeMore,
                onTap: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            ProfileAction(
              icon: FeatherIcons.logOut,
              text: _locale.exitButton,
              onCardTap: () {},
            ),
          ],
        ),
      );

  LineTextButton get activateButton => LineTextButton(
        text: _locale.activate,
        onTap: () {
          setState(() {
            notification = true;
          });
        },
      );

  LineTextButton get desactiveButton => LineTextButton(
        text: _locale.activated + '!',
        onTap: () {
          setState(() {
            notification = false;
          });
        },
        textStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: TheoColors.twentyThree, fontSize: 14),
      );
}
