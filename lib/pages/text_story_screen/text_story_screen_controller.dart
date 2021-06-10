import 'package:mobx/mobx.dart';
import 'package:theo/models/story.dart';
import 'package:theo/states/story_store.dart';
part 'text_story_screen_controller.g.dart';

class TextStoryScreenController = _TextStoryScreenControllerBase
    with _$TextStoryScreenController;

abstract class _TextStoryScreenControllerBase with Store {
  _TextStoryScreenControllerBase(
      {required this.story, required this.storyStore});

  final Story story;
  final StoryStore storyStore;
}
