import 'package:supabase/supabase.dart' as sup;
import 'package:theo/core/constants/posts_consts.dart';
import 'package:theo/models/post.dart';
import 'package:theo/models/story.dart';
import 'package:theo/models/user.dart';

import 'api_client.dart';

class PostService {
  PostService(this.client);

  final APIClient client;

  Future<sup.PostgrestResponse?> fetchPosts(int page) async {
    var supabasePage = 0;

    if (page - 1 <= 0) {
      supabasePage = 0;
    } else {
      supabasePage = (page - 1) * PostsConsts.POST_PAGE_SIZE;
    }

    var response = await client.supabase
        .from('posts')
        .select('''
    *,
    user: user_id (
      *,
      profile: profile_id (*)
      ),
    story: story_id (
      *,
      language: language_id (*),
      category: category_id (*),
      format: format_id (*),
      files (*)
    ),
    likes_count: post_likes (
      count
    ),
    comments_count: post_comments (
       count
    )
    ''')
        .order('created_at', ascending: false)
        .range(supabasePage, supabasePage + PostsConsts.POST_PAGE_SIZE - 1)
        .execute(count: sup.CountOption.exact);

    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return response;
  }

  Future<sup.PostgrestResponse?> createPost({
    required Story story,
    required List<String> filesPath,
    required User user,
  }) async {
    var storyResponse = await client.storyService
        .createStory(story: story, filesPath: filesPath);

    var newPost =
        Post(storyId: storyResponse!.data.first['id'], userId: user.id);

    var response = await client.supabase
        .from('posts')
        .insert(newPost.toJson(withId: false))
        .execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    return response;
  }
}
