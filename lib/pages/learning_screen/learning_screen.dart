import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/storyProgress.dart';
import 'package:theo/components/title_text.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/models/story.dart';
import 'package:theo/pages/learning_screen/components/story_card.dart';
import 'package:theo/styles/colors.dart';

class LearningScreen extends StatefulWidget {
  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  List<Story> stories = [
    Story(
      title: 'Primeiro titulo aqui - Sobre o storytelling?',
      finished: true,
    ),
    Story(
      title: 'Direitos Autorais',
    ),
    Story(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      finished: false,
    ),
    Story(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      finished: false,
    ),
    Story(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      finished: false,
    ),
    Story(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      finished: false,
    ),
    Story(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      finished: false,
    ),
    Story(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      finished: false,
    ),
    Story(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      finished: false,
    ),
  ];

  void _presentationTap() {
    Navigator.of(context).pushNamed(Routes.videoLearn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16, top: 38),
            child: _title,
          ),
          StoryProgress(
            progress: 3,
            total: 5,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 27),
          ),
          Expanded(child: _list),
          Container(
            margin: EdgeInsets.only(bottom: 20),
          )
        ],
      ),
    );
  }

  Widget get _presentation => InkWell(
        onTap: _presentationTap,
        child: Container(
          child: Card(
            elevation: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 17),
              child: Row(
                children: [
                  Icon(
                    FeatherIcons.playCircle,
                    color: TheoColors.primary,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                  ),
                  Text(
                    'Apresentação',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: TheoColors.seven,
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget get _list => ListView.builder(
      itemCount: stories.length + 1,
      itemBuilder: (_, int index) {
        if (index == 0) return _presentation;

        return StoryCard(
          story: stories[index - 1],
        );
      });

  Widget get _title => TitleText(
        title: 'Como contar?',
      );
}
