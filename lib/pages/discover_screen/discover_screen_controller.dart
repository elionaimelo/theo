import 'package:mobx/mobx.dart';
import 'package:theo/models/post.dart';
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

  @observable
  String errorMessage = '';

  @computed
  List<Post> get posts => postStore.posts;

  @action
  Future<void> fetchData() async {
    try {
      eResultStatus = EResultStatus.LOADING;

      await postStore.fetchPosts();

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      errorMessage = err.toString();
      eResultStatus = EResultStatus.REQUEST_ERROR;
    }
  }
}
