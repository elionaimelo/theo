import 'package:mobx/mobx.dart';
import 'package:theo/models/post.dart';
import 'package:theo/models/story.dart';
import 'package:theo/states/story_store.dart';
import 'package:theo/types/enums.dart';
part 'graph_story_screen_controller.g.dart';

class GraphStoryScreenController = _GraphStoryScreenControllerBase
    with _$GraphStoryScreenController;

abstract class _GraphStoryScreenControllerBase with Store {
  _GraphStoryScreenControllerBase(
      {required this.post, required this.storyStore});

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  final Post post;
  final StoryStore storyStore;
}
