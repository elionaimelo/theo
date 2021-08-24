import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:theo/core/constants/story_format_consts.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/models/post.dart';
import 'package:theo/models/story.dart';
import 'package:theo/pages/graph_story_screen/graph_story_screen_controller.dart';
import 'package:theo/pages/media_story_screen/media_story_screen_controller.dart';
import 'package:theo/pages/quiz_story_screen/quiz_story_screen_controller.dart';
import 'package:theo/pages/storytelling_learn_screen/components/learn_card_item.dart';
import 'package:theo/pages/storytelling_learn_screen/storytelling_learn_screen_controller.dart';
import 'package:theo/pages/text_story_screen/text_story_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StorytellingLearnScreen extends StatefulWidget {
  const StorytellingLearnScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _StorytellingLearnScreenState createState() =>
      _StorytellingLearnScreenState();

  final StorytellingLearnScreenController controller;
}

class _StorytellingLearnScreenState extends State<StorytellingLearnScreen> {
  AppLocalizations get _locale => AppLocalizations.of(context)!;

  void onTapCard(Story story) {
    var name = story.format!.name;

    switch (name) {
      case StoryFormatConsts.VIDEO:
      case StoryFormatConsts.PODCAST:
        Navigator.of(context).pushNamed(
          Routes.mediaStory,
          arguments: MediaStoryScreenController(
            story: story,
            storyStore: GetIt.I.get(),
          ),
        );
        break;

      case StoryFormatConsts.INFROGRAPHIC:
        Navigator.of(context).pushNamed(
          Routes.graphStory,
          arguments: GraphStoryScreenController(
            post: Post(story: story),
            storyStore: GetIt.I.get(),
          ),
        );
        break;

      case StoryFormatConsts.TEXT:
        Navigator.of(context).pushNamed(Routes.textStory,
            arguments: TextStoryScreenController(
              story: story,
              storyStore: GetIt.I.get(),
            ));
        break;

      case StoryFormatConsts.QUIZ:
        Navigator.of(context).pushNamed(
          Routes.quizStory,
          arguments: QuizStoryScreenController(
            story: story,
            storyStore: GetIt.I.get(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TheoColors.secondary,
      padding: TheoMetrics.paddingScreen,
      child: ListView(
        children: [
          Text(
            _locale.learningStoryTitle,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: TheoColors.seven,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
          ),
          _cardItens,
        ],
      ),
    );
  }

  Widget get _cardItens {
    return Observer(
      builder: (_) {
        var nextSelected = _nextSelected;

        var list = widget.controller.stories
            .asMap()
            .entries
            .map(
              (e) => LearnCardItem(
                number: (e.key + 1).toString(),
                selected: e.value == nextSelected,
                story: e.value,
                onTap: () => onTapCard(e.value),
              ),
            )
            .toList();

        return Column(
          children: list,
        );
      },
    );
  }

  Story get _nextSelected =>
      widget.controller.stories.firstWhere((element) => !element.finished,
          orElse: () => Story(id: '-1', sectionId: '-1'));
}
