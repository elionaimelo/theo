import 'package:mobx/mobx.dart';
import 'package:theo/core/constants/story_format_consts.dart';
import 'package:theo/mocks/theo_mocks.dart';
import 'package:theo/models/story_format.dart';
import 'package:theo/models/story.dart';
import 'package:theo/services/api_client.dart';
import 'package:theo/services/story_service.dart';
import 'package:theo/types/enums.dart';
part 'story_store.g.dart';

class StoryStore = _StoryStoreBase with _$StoryStore;

abstract class _StoryStoreBase with Store {
  _StoryStoreBase(this.client);

  final APIClient client;

  StoryService get _storyService => client.storyService;

  @observable
  List<Story> stories = [];

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @action
  Future<void> createUploadStory(
      {required Story story, required List<String> filesPath}) async {
    try {
      eResultStatus = EResultStatus.LOADING;

      var response =
          await _storyService.createStory(story: story, filesPath: filesPath);

      if (response == null) {
        throw Exception('Response Null');
      }

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      print('StoryStore.createUploadStory - $err');
      eResultStatus = EResultStatus.REQUEST_ERROR;
      rethrow;
    }
  }

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
