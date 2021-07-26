import 'package:mobx/mobx.dart';
import 'package:theo/mocks/theo_mocks.dart';
import 'package:theo/models/story.dart';
import 'package:theo/services/api_client.dart';
import 'package:theo/types/enums.dart';
part 'story_store.g.dart';

class StoryStore = _StoryStoreBase with _$StoryStore;

abstract class _StoryStoreBase with Store {
  _StoryStoreBase(this.client);

  final APIClient client;

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

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

  @observable
  List<Story> learningStories = TheoMocks.learningStories;
}
