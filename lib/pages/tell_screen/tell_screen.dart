import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theo/components/subTitleText.dart';
import 'package:theo/components/titleText.dart';
import 'package:theo/pages/new_tell_screen/new_tell_screen.dart';
import 'package:theo/pages/tell_screen/components/tell_menu_item.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/assetsPath.dart';

class TellScreen extends StatefulWidget {
  @override
  _TellScreenState createState() => _TellScreenState();
}

class _TellScreenState extends State<TellScreen> {
  void _onVideoTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewTellScreen(
          title: 'Video',
        ),
      ),
    );
  }

  List<Widget> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      Container(
        margin: EdgeInsets.only(top: 5),
        child: TellMenuItem(
          icon: Icon(
            FeatherIcons.video,
            color: TheoColors.eleven,
          ),
          text: 'Vídeo',
          onTap: () => _onVideoTap(),
        ),
      ),
      TellMenuItem(
        icon: SvgPicture.asset(AssetsPath.animationSvg),
        text: 'Animação',
      ),
      TellMenuItem(
        icon: Icon(
          FeatherIcons.fileText,
          color: TheoColors.primary,
        ),
        text: 'Texto',
      ),
      TellMenuItem(
        icon: SvgPicture.asset(AssetsPath.comicSvg),
        text: 'HQ',
      ),
      TellMenuItem(
        icon: SvgPicture.asset(AssetsPath.gameSvg),
        text: 'Jogo',
      ),
      TellMenuItem(
        icon: Icon(
          FeatherIcons.pieChart,
          color: TheoColors.primary,
        ),
        text: 'Infográfico',
      ),
      TellMenuItem(
        icon: Icon(
          FeatherIcons.image,
          color: TheoColors.eleven,
        ),
        text: 'Imagem',
      ),
      TellMenuItem(
        icon: SvgPicture.asset(AssetsPath.interactiveSvg),
        text: 'Figura interativa',
      ),
      TellMenuItem(
        icon: Icon(
          FeatherIcons.music,
          color: TheoColors.primary,
        ),
        text: 'Música',
      ),
      TellMenuItem(
        icon: Icon(
          FeatherIcons.radio,
          color: TheoColors.eleven,
        ),
        text: 'Podcast',
      ),
      Container(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _title,
                SubTitleText(
                  subTitle: 'Selecione a opção que deseja compartilhar',
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
          ),
          Expanded(child: _list),
        ],
      ),
    );
  }

  Widget get _list => ListView.separated(
        itemBuilder: (_, int i) => items[i],
        separatorBuilder: (_, int i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(
            height: 1,
            thickness: 1,
          ),
        ),
        itemCount: items.length,
      );

  Widget get _title => TitleText(
        title: 'Contar uma história',
      );
}
