import 'package:mobx/mobx.dart';
import 'package:theo/models/story.dart';
import 'package:theo/states/story_store.dart';
part 'graph_story_screen_controller.g.dart';

class GraphStoryScreenController = _GraphStoryScreenControllerBase
    with _$GraphStoryScreenController;

abstract class _GraphStoryScreenControllerBase with Store {
  _GraphStoryScreenControllerBase(
      {required this.story, required this.storyStore});

  final Story story;
  final StoryStore storyStore;
}
