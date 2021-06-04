import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/models/enums.dart';
import 'package:theo/models/story.dart';
import 'package:theo/pages/graph_story_screen/graph_story_screen_controller.dart';
import 'package:theo/pages/quiz_story_screen/quiz_story_screen_controller.dart';
import 'package:theo/pages/storytelling_learn_screen/components/learn_card_item.dart';
import 'package:theo/pages/storytelling_learn_screen/storytelling_learn_screen_controller.dart';
import 'package:theo/pages/video_story_screen/video_story_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

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
  void onTapCard(Story story) {
    switch (story.format) {
      case EStoryFormat.VIDEO:
      case EStoryFormat.PODCAST:
        Navigator.of(context).pushNamed(
          Routes.videoStory,
          arguments: VideoStoryScreenController(
            story: story,
            storyStore: GetIt.I.get(),
          ),
        );
        break;

      case EStoryFormat.TEXT:
        Navigator.of(context).pushNamed(Routes.textStory);
        break;

      case EStoryFormat.QUIZ:
        Navigator.of(context).pushNamed(
          Routes.quizStory,
          arguments: QuizStoryScreenController(
            story: story,
            storyStore: GetIt.I.get(),
          ),
        );
        break;

      case EStoryFormat.INFROGRAPHIC:
        Navigator.of(context).pushNamed(
          Routes.graphStory,
          arguments: GraphStoryScreenController(
            story: story,
            storyStore: GetIt.I.get(),
          ),
        );
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TheoMetrics.paddingScreen,
      child: ListView(
        children: [
          Text(
            'Primeiro título aqui - sobre o storytelling',
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
      widget.controller.stories.firstWhere((element) => !element.finished);
}
