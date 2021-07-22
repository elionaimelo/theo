import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:theo/components/story_progress.dart';
import 'package:theo/components/title_text.dart';
import 'package:theo/core/constants/story_format_consts.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/models/story_format.dart';
import 'package:theo/models/section.dart';
import 'package:theo/models/story.dart';
import 'package:theo/mocks/theo_mocks.dart';
import 'package:theo/pages/learning_screen/components/section_card.dart';
import 'package:theo/pages/media_story_screen/media_story_screen_controller.dart';
import 'package:theo/styles/colors.dart';

class LearningScreen extends StatefulWidget {
  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  List<Section> sections = TheoMocks.sectionsMock;

  void _onStoryCardTap() {
    Navigator.of(context).pushNamed(Routes.storytellingLearn);
  }

  void _presentationTap() {
    Navigator.of(context).pushNamed(
      Routes.mediaStory,
      arguments: MediaStoryScreenController(
        story: Story(
          title: 'Aprendendo a gravar vídeos com o celular',
          id: '1',
          sectionId: '-1',
          url:
              'https://github.com/elionaimelo/theo/raw/pre-validacao/others/videos/educacional_celular.mp4',
          format: StoryFormat(name: StoryFormatConsts.VIDEO),
        ),
        storyStore: GetIt.I.get(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TheoColors.secondary,
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
        itemCount: sections.length + 1,
        itemBuilder: (_, int index) {
          if (index == 0) return _presentation;

          return SectionCard(
            section: sections[index - 1],
            onStartTap: _onStoryCardTap,
          );
        },
      );

  Widget get _title => TitleText(
        title: 'Como contar?',
      );
}
