import 'package:mobx/mobx.dart';
import 'package:theo/states/post_store.dart';
import 'package:theo/types/enums.dart';
part 'discover_screen_controller.g.dart';

class DiscoverScreenController = _DiscoverScreenControllerBase
    with _$DiscoverScreenController;

abstract class _DiscoverScreenControllerBase with Store {
  _DiscoverScreenControllerBase({
    required this.postStore,
  });

  final PostStore postStore;

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @action
  Future<void> fetchPosts({int? page}) async {
    try {
      eResultStatus = EResultStatus.LOADING;

      await postStore.fetchPosts(page: page);

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      eResultStatus = EResultStatus.REQUEST_ERROR;
    }
  }
}
