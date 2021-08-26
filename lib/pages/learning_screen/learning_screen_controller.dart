import 'package:mobx/mobx.dart';
import 'package:theo/models/section.dart';
import 'package:theo/states/story_store.dart';
part 'learning_screen_controller.g.dart';

class LearningScreenController = _LearningScreenControllerBase
    with _$LearningScreenController;

abstract class _LearningScreenControllerBase with Store {
  _LearningScreenControllerBase({required this.storyStore});
  final StoryStore storyStore;

  @computed
  List<Section> get sections => storyStore.sections;
}
