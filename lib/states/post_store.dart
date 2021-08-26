import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';
import 'package:theo/core/constants/posts_consts.dart';
import 'package:theo/models/post.dart';
import 'package:theo/models/story.dart';
import 'package:theo/models/user.dart';
import 'package:theo/services/api_client.dart';
import 'package:theo/services/post_service.dart';
import 'package:theo/types/enums.dart';
import 'package:supabase/supabase.dart' as sup;

part 'post_store.g.dart';

class PostStore = _PostStoreBase with _$PostStore;

abstract class _PostStoreBase with Store {
  _PostStoreBase(this.client) {
    pagingController.addPageRequestListener((pageKey) {
      fetchPosts(page: pageKey);
    });
  }

  final APIClient client;

  PostService get _postService => client.postService;

  final pagingController = PagingController<int, Post>(
    firstPageKey: 1,
  );

  @observable
  int totalPostsCount = 0;

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @observable
  List<Post> fetchedPosts = [];

  bool isLastPage(int page) =>
      page * PostsConsts.POST_PAGE_SIZE >= totalPostsCount;

  bool isFirstPage(int page) => page == pagingController.firstPageKey;

  @action
  Future<void> fetchPosts({int? page}) async {
    eResultStatus = EResultStatus.LOADING;

    try {
      var nextPage = page ?? pagingController.firstPageKey;

      if (isFirstPage(nextPage)) {
        pagingController.itemList = null;
      }

      var response = await _postService.fetchPosts(nextPage);

      totalPostsCount = response?.count ?? 0;

      var listResult = [...response?.data];

      var posts = listResult.map((e) => Post.fromJson(e) ?? Post()).toList();

      if (isLastPage(nextPage)) {
        pagingController.appendLastPage(posts);
      } else {
        var futurePage = nextPage + 1;
        pagingController.appendPage(posts, futurePage);
        fetchedPosts = pagingController.itemList ?? [];
      }

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      print('PostStore.fetchPosts - $err');
      pagingController.error = err;
      eResultStatus = EResultStatus.REQUEST_ERROR;
      rethrow;
    }
  }

  @action
  Future<sup.PostgrestResponse?> createPost({
    required Story story,
    required List<String> filesPath,
    required User user,
  }) async {
    try {
      eResultStatus = EResultStatus.LOADING;

      var response = await _postService.createPost(
        story: story,
        filesPath: filesPath,
        user: user,
      );

      if (response == null) {
        throw Exception(null);
      }

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      print('PostStore.createPost - $err');
      eResultStatus = EResultStatus.REQUEST_ERROR;
      rethrow;
    }
  }
}
