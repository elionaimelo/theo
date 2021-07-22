import 'package:mobx/mobx.dart';
import 'package:theo/models/story_format.dart';
import 'package:theo/services/api_client.dart';
import 'package:theo/services/story_format_service.dart';
import 'package:theo/types/enums.dart';
part 'story_format_store.g.dart';

class StoryFormatStore = _StoryFormatStoreBase with _$StoryFormatStore;

abstract class _StoryFormatStoreBase with Store {
  _StoryFormatStoreBase(this.client);

  final APIClient client;

  StoryFormatService get _storyCategoryService => client.storyFormatService;

  @observable
  List<StoryFormat> storyFormats = [];

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @action
  Future<void> fetchStoryFormats() async {
    eResultStatus = EResultStatus.LOADING;

    try {
      var response = await _storyCategoryService.fetchStoryFormats();

      if (response == null) {
        throw Exception('Response Null');
      }

      var listResult = [...response.data];

      storyFormats = listResult.map((e) => StoryFormat.fromJson(e)!).toList();

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      print('StoryFormatStore.fetchStoryFormats - $err');
      eResultStatus = EResultStatus.REQUEST_ERROR;
      rethrow;
    }
  }
}
