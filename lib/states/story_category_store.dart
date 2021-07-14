import 'package:mobx/mobx.dart';
import 'package:theo/models/story_category.dart';
import 'package:theo/services/api_client.dart';
import 'package:theo/services/story_category_service.dart';
import 'package:theo/types/enums.dart';
part 'story_category_store.g.dart';

class StoryCategoryStore = _StoryCategoryStoreBase with _$StoryCategoryStore;

abstract class _StoryCategoryStoreBase with Store {
  _StoryCategoryStoreBase(this.client);

  final APIClient client;

  StoryCategoryService get _storyCategoryService => client.storyCategoryService;

  @observable
  List<StoryCategory> storyCategories = [];

  @observable
  ResultStatus resultStatus = ResultStatus.NONE;

  @action
  Future<void> fetchStoryCategories() async {
    resultStatus = ResultStatus.LOADING;

    try {
      var response = await _storyCategoryService.fetchStoryCategories();

      if (response == null) {
        throw Exception('Response Null');
      }

      var listResult = [...response.data];

      storyCategories =
          listResult.map((e) => StoryCategory.fromJson(e)!).toList();

      resultStatus = ResultStatus.DONE;
    } catch (err) {
      print('StoryCategoryStore.fetchStoryCategories - $err');
      resultStatus = ResultStatus.REQUEST_ERROR;
      rethrow;
    }
  }
}
