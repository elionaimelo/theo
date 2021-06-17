import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/post_card_actions.dart';
import 'package:theo/components/profile_bar.dart';
import 'package:theo/components/story_app_bar.dart';
import 'package:theo/components/text_icon_button.dart';
import 'package:theo/pages/discover_game_screen/components/expandable_text.dart';
import 'package:theo/pages/discover_game_screen/components/image_carousel.dart';
import 'package:theo/pages/discover_game_screen/discover_game_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/utils/assets_path.dart';

class DiscoverGameScreen extends StatefulWidget {
  const DiscoverGameScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _DiscoverGameScreenState createState() => _DiscoverGameScreenState();

  final DiscoverGameScreenController controller;
}

class _DiscoverGameScreenState extends State<DiscoverGameScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin:
              EdgeInsets.fromLTRB(0, AppBar().preferredSize.height / 2, 0, 0),
          padding: TheoMetrics.paddingScreen.copyWith(left: 0, right: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topContent,
              Expanded(
                child: Stack(
                  children: [
                    _bottomContent,
                    ExpandableText(
                      text:
                          'At vero eos et accusam et justo duo Dolores et ea rebum. Stet clita kasd gubergren, no sea. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy. At vero eos et accusam et justo duo Dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy.',
                      author: 'Beutrano Cunha',
                      adultContent: false,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _topContent => Container(
        padding: EdgeInsets.symmetric(
          horizontal: TheoMetrics.paddingScreen.left,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StoryAppBar(),
            Container(
              margin: EdgeInsets.only(top: 45),
            ),
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
          ],
        ),
      );

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

  Widget get _bottomContent => Container(
        padding: TheoMetrics.paddingScreen.copyWith(top: 0, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ImageCarrossel(
              imageAssets: [AssetsPath.criancaPng, AssetsPath.hqPng],
              title: 'Clique na imagem para ampliar',
            ),
            Container(
              margin: EdgeInsets.only(top: 23),
            ),
            BottomButton(
              text: 'Acesse aqui o jogo',
              backgroundColor: Colors.transparent,
              primaryColor: TheoColors.primary,
              borderColor: TheoColors.primary,
            ),
            PostCardActions(
              likesCount: 16,
              commentsCount: 4,
              horizontalPadding: 0,
            ),
          ],
        ),
      );
}
