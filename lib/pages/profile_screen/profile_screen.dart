import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/line_text_button.dart';
import 'package:theo/components/subTitleText.dart';
import 'package:theo/components/title_text.dart';
import 'package:theo/pages/profile_screen/components/profile_action.dart';
import 'package:theo/pages/profile_screen/components/profile_data_field.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notification = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TheoMetrics.paddingScreen,
      child: ListView(
        children: [
          TitleText(
            title: 'Meu perfil',
          ),
          SubTitleText(
            subTitle: 'Aqui você pode alterar as configurações da sua conta',
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
            LineTextButton(text: 'Alterar foto do perfil', onTap: () {}),
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
            ProfileDataField(
              textLabel: 'Nome',
              textValue: 'Astrogilda Nunes',
              onTap: () {},
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
            ),
            ProfileDataField(
              textLabel: 'E-mail',
              textValue: 'astrogilda-n@gmail.com',
              onTap: () {},
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
            ),
            ProfileDataField(
              textLabel: 'Nome',
              textValue: 'password',
              onTap: () {},
              obscureText: true,
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
              text: 'Notificações',
              sufixButton: notification ? desactiveButton : activateButton,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            ProfileAction(
              icon: FeatherIcons.xCircle,
              text: 'Cancelar conta',
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
              text: 'Histórias salvas',
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
              text: 'Histórico de publicações',
              sufixButton: LineTextButton(
                text: 'ver mais',
                onTap: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            ProfileAction(
              icon: FeatherIcons.messageSquare,
              text: 'Compartilhar história',
              sufixButton: LineTextButton(
                text: 'ver mais',
                onTap: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            ProfileAction(
              icon: FeatherIcons.logOut,
              text: 'Sair',
              onCardTap: () {},
            ),
          ],
        ),
      );

  LineTextButton get activateButton => LineTextButton(
        text: 'ativar',
        onTap: () {
          setState(() {
            notification = true;
          });
        },
      );

  LineTextButton get desactiveButton => LineTextButton(
        text: 'Ativado!',
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
