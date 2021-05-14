import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theo/components/profile_bar.dart';
import 'package:theo/components/text_icon_button.dart';
import 'package:theo/pages/discover_game_screen/components/expandable_text.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/utils/assets_path.dart';

class DiscoverGameScreen extends StatefulWidget {
  @override
  _DiscoverGameScreenState createState() => _DiscoverGameScreenState();
}

class _DiscoverGameScreenState extends State<DiscoverGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TheoMetrics.paddingScreen,
      child: ListView(
        children: [
          ProfileBar(
            avatarImage: AssetsPath.avatarJpg,
            name: 'Kaline Sampaio',
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
          ),
          _title,
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: _portugueseTag,
          ),
          Stack(
            children: [
              ExpandableText(
                text:
                    'At vero eos et accusam et justo duo Dolores et ea rebum. Stet clita kasd gubergren, no sea. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy. At vero eos et accusam et justo duo Dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy.',
                author: 'Beutrano Cunha',
                adultContent: false,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget get _title => Text(
        'Nome do jogo lorem ipsum dolor',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
      );

  Widget get _portugueseTag => TextIconButton(
        innerPadding: EdgeInsets.zero,
        foregroundColor: TheoColors.secondary,
        text: 'Português',
        onTap: () {},
        direction: TextDirection.ltr,
        icon: Container(
          margin: EdgeInsets.only(right: 10),
          child: SvgPicture.asset(
            AssetsPath.brSvg,
            height: 28,
          ),
        ),
        textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 16,
              color: TheoColors.twentyTwo,
            ),
      );

  Widget get _bottomContent => Column(
        children: [],
      );
}
