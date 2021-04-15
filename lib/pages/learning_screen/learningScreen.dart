import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/storyProgress.dart';
import 'package:theo/components/titleText.dart';
import 'package:theo/models/story.dart';
import 'package:theo/pages/learning_screen/components/storyCard.dart';
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
          _presentation,
          Expanded(child: _list),
          Container(
            margin: EdgeInsets.only(bottom: 20),
          )
        ],
      ),
    );
  }

  Widget get _presentation => InkWell(
        onTap: () {},
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
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
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
        itemCount: stories.length,
        itemBuilder: (_, int index) => StoryCard(
          story: stories[index],
        ),
      );

  Widget get _title => TitleText(
        title: 'Como contar?',
      );
}
