import 'package:flutter/material.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/lang_icon.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  AppLocalizations get _locale => AppLocalizations.of(context)!;

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
                      text: widget.controller.post.story?.description ?? '-',
                      author: widget.controller.post.story?.author ?? '-',
                      adultContent:
                          widget.controller.post.story?.adultContent ?? false,
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
              name: widget.controller.post.user?.profile?.name ?? '-',
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
        widget.controller.post.story?.title ?? '-',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
      );

  Widget get _portugueseTag => TextIconButton(
        innerPadding: EdgeInsets.zero,
        foregroundColor: TheoColors.secondary,
        text: widget.controller.post.story?.language?.displayName ?? '-',
        onTap: () {},
        direction: TextDirection.ltr,
        icon: LangIcon(
          languageCode: widget.controller.post.languageName,
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
              imageFiles: widget.controller.post.story?.imageFiles ?? [],
              title: _locale.imageCarrosselTitle,
            ),
            Container(
              margin: EdgeInsets.only(top: 23),
            ),
            BottomButton(
              text: _locale.openGameButton,
              backgroundColor: Colors.transparent,
              primaryColor: TheoColors.primary,
              borderColor: TheoColors.primary,
              onPressed: () => widget.controller
                  .openGameButtonTap(widget.controller.post.story?.url ?? '-'),
            ),
            PostCardActions(
              likesCount: widget.controller.post.likesCount,
              commentsCount: widget.controller.post.commentsCount,
              horizontalPadding: 0,
            ),
          ],
        ),
      );
}
