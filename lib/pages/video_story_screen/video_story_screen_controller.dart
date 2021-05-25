import 'package:mobx/mobx.dart';
import 'package:theo/models/story.dart';
import 'package:theo/states/story_store.dart';
part 'video_story_screen_controller.g.dart';

class VideoStoryScreenController = _VideoStoryScreenControllerBase
    with _$VideoStoryScreenController;

abstract class _VideoStoryScreenControllerBase with Store {
  _VideoStoryScreenControllerBase({
    required this.storyStore,
    required this.story,
  });

  final StoryStore storyStore;

  final Story story;
}
