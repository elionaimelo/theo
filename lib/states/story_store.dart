import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:theo/core/constants/story_format_consts.dart';
import 'package:theo/models/section.dart';
import 'package:theo/models/story.dart';
import 'package:theo/models/story_format.dart';
import 'package:theo/services/api_client.dart';
import 'package:theo/types/enums.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'story_store.g.dart';

class StoryStore = _StoryStoreBase with _$StoryStore;

abstract class _StoryStoreBase with Store {
  _StoryStoreBase(this.client);

  final APIClient client;

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @observable
  List<Section> sections = [];

  @action
  void finishLearningStory(String id) {
    learningStories = learningStories.map((e) {
      if (e.id == id) {
        e.finished = true;

        return e;
      }
      return e;
    }).toList();
  }

  bool isSectionFinished(String sectionId) {
    return learningStories.every((element) {
      // Ignore the stories from another sections
      if (element.sectionId != sectionId) return true;

      return element.finished;
    });
  }

  @action
  void loadLearningStories(BuildContext context) {
    if (learningStories.isNotEmpty) return;

    var locale = AppLocalizations.of(context)!;

    sections = [
      Section(
        title: locale.section1,
        id: '1',
      ),
      Section(
        title: locale.section2,
        id: '2',
      )
    ];

    learningStories = [
      Story(
        id: '1',
        sectionId: '1',
        finished: false,
        format: StoryFormat(name: StoryFormatConsts.VIDEO),
        title: locale.learningStoryTitle,
        url: locale.learningStoryLink,
      ),
      Story(
        id: '2',
        sectionId: '1',
        finished: false,
        format: StoryFormat(name: StoryFormatConsts.PODCAST),
        title: locale.learningStory2Title,
        url: locale.learningStory2Link,
      ),
    ];
  }

  @observable
  List<Story> learningStories = [];
}
