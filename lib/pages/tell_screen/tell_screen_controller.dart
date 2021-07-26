import 'package:mobx/mobx.dart';
import 'package:theo/models/story_format.dart';
import 'package:theo/states/story_format_store.dart';
import 'package:theo/types/enums.dart';
part 'tell_screen_controller.g.dart';

class TellScreenController = _TellScreenControllerBase
    with _$TellScreenController;

abstract class _TellScreenControllerBase with Store {
  _TellScreenControllerBase({required this.storyFormatStore});

  final StoryFormatStore storyFormatStore;

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @observable
  String errorMessage = '';

  @computed
  List<StoryFormat> get storyFormats => storyFormatStore.storyFormats;

  @action
  Future<void> fetchData() async {
    try {
      eResultStatus = EResultStatus.LOADING;

      await storyFormatStore.fetchStoryFormats();

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      errorMessage = err.toString();
      eResultStatus = EResultStatus.REQUEST_ERROR;
    }
  }
}
