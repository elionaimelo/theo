import 'package:mobx/mobx.dart';
import 'package:theo/models/post.dart';
import 'package:theo/services/api_client.dart';
import 'package:theo/services/post_service.dart';
import 'package:theo/types/enums.dart';
part 'post_store.g.dart';

class PostStore = _PostStoreBase with _$PostStore;

abstract class _PostStoreBase with Store {
  _PostStoreBase(this.client);

  final APIClient client;

  PostService get _postService => client.postService;

  @observable
  List<Post> posts = [];

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @action
  Future<void> fetchPosts() async {
    eResultStatus = EResultStatus.LOADING;

    try {
      var response = await _postService.fetchPosts();

      if (response == null) {
        throw Exception('Response Null');
      }

      var listResult = [...response.data];

      posts = listResult.map((e) => Post.fromJson(e)!).toList();

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      print('PostStore.fetchPosts - $err');
      eResultStatus = EResultStatus.REQUEST_ERROR;
      rethrow;
    }
  }
}
