import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theo/components/subTitleText.dart';
import 'package:theo/components/title_text.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/pages/new_tell_screen/new_tell_screen.dart';
import 'package:theo/pages/tell_screen/components/tell_menu_item.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/assets_path.dart';

class TellScreen extends StatefulWidget {
  @override
  _TellScreenState createState() => _TellScreenState();
}

class _TellScreenState extends State<TellScreen> {
  void _onMenuItemTap(NewTellScreenArgs args) {
    Navigator.pushNamed(
      context,
      Routes.newTell,
      arguments: args,
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
          onTap: () => _onMenuItemTap(NewTellScreenArgs(title: 'Video')),
        ),
      ),
      TellMenuItem(
        icon: SvgPicture.asset(AssetsPath.animationSvg),
        text: 'Animação',
        onTap: () => _onMenuItemTap(
            NewTellScreenArgs(title: 'Animação', withLink: true)),
      ),
      TellMenuItem(
        icon: Icon(
          FeatherIcons.fileText,
          color: TheoColors.primary,
        ),
        text: 'Texto',
        onTap: () => _onMenuItemTap(
            NewTellScreenArgs(title: 'Texto', withArchive: true)),
      ),
      TellMenuItem(
        icon: SvgPicture.asset(AssetsPath.comicSvg),
        text: 'HQ',
        onTap: () => _onMenuItemTap(NewTellScreenArgs(
          title: 'HQ',
        )),
      ),
      TellMenuItem(
        icon: SvgPicture.asset(AssetsPath.gameSvg),
        text: 'Jogo',
        onTap: () =>
            _onMenuItemTap(NewTellScreenArgs(title: 'Jogo', withLink: true)),
      ),
      TellMenuItem(
        icon: Icon(
          FeatherIcons.pieChart,
          color: TheoColors.primary,
        ),
        text: 'Infográfico',
        onTap: () => _onMenuItemTap(
            NewTellScreenArgs(title: 'Infográfico', withArchive: true)),
      ),
      TellMenuItem(
        icon: Icon(
          FeatherIcons.image,
          color: TheoColors.eleven,
        ),
        text: 'Imagem',
        onTap: () => _onMenuItemTap(NewTellScreenArgs(title: 'Imagem')),
      ),
      TellMenuItem(
        icon: SvgPicture.asset(AssetsPath.interactiveSvg),
        text: 'Figura interativa',
        onTap: () =>
            _onMenuItemTap(NewTellScreenArgs(title: 'Figura Interativa')),
      ),
      TellMenuItem(
        icon: Icon(
          FeatherIcons.music,
          color: TheoColors.primary,
        ),
        text: 'Música',
        onTap: () => _onMenuItemTap(
            NewTellScreenArgs(title: 'Música', withArchive: true)),
      ),
      TellMenuItem(
        icon: Icon(
          FeatherIcons.radio,
          color: TheoColors.eleven,
        ),
        text: 'Podcast',
        onTap: () =>
            _onMenuItemTap(NewTellScreenArgs(title: 'Podcast', withLink: true)),
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
