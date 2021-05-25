import 'package:mobx/mobx.dart';
import 'package:theo/models/story.dart';
import 'package:theo/states/story_store.dart';
part 'storytelling_learn_screen_controller.g.dart';

class StorytellingLearnScreenController = _StorytellingLearnScreenControllerBase
    with _$StorytellingLearnScreenController;

abstract class _StorytellingLearnScreenControllerBase with Store {
  _StorytellingLearnScreenControllerBase({required this.storyStore});

  final StoryStore storyStore;

  @computed
  List<Story> get stories => storyStore.stories;
}
