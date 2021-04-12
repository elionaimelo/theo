import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/components/story_progress.dart';
import 'package:theo/components/titleText.dart';
import 'package:theo/models/story.dart';
import 'package:theo/pages/learning_screen/components/story_card.dart';

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
          Expanded(child: _list),
          Container(
            margin: EdgeInsets.only(bottom: 20),
          )
        ],
      ),
    );
  }

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
