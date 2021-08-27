import 'package:theo/core/constants/file_consts.dart';
import 'package:theo/models/file.dart';
import 'package:theo/models/post_commnet.dart';
import 'package:theo/models/post_likes.dart';
import 'package:theo/models/story.dart';
import 'package:theo/models/user.dart';
import 'package:theo/utils/json_utils.dart';

class Post {
  Post({
    this.id,
    this.userId,
    this.storyId,
    this.user,
    this.story,
    this.comments = const [],
    this.likes = const [],
    this.commentsCount,
    this.likesCount,
  });

  String? id;
  String? userId;
  String? storyId;

  User? user;
  Story? story;

  List<PostComment> comments;
  List<PostLike> likes;

  int? likesCount;
  int? commentsCount;

  File? get thumbnailImage {
    if (story == null || story?.imageFiles.isEmpty == true) return null;

    return story!.imageFiles.first;
  }

  File? get mediaFile {
    if (story == null || story?.files.isEmpty == true) return null;

    try {
      return story!.files.firstWhere(
        (element) => FileConsts.MEDIA_EXTS.contains(element.ext),
      );
    } catch (err) {
      print('Post.mediaFile - $err');
      rethrow;
    }
  }

  String? get languageName {
    return story?.language?.name;
  }

  Map<String, dynamic> toJson({bool withId = true}) => {
        if (withId) 'id': id,
        'user_id': userId,
        'story_id': storyId,
      };

  static Post? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    try {
      return Post(
        id: json['id'],
        userId: json['user_id'],
        storyId: json['story_id'],
        user: User.fromJson(json['user']),
        story: Story.fromJson(json['story']),
        comments: (json['comments'] as List<dynamic>?)
                ?.map((e) => PostComment.fromJson(e)!)
                .toList() ??
            [],
        likes: (json['likes'] as List<dynamic>?)
                ?.map((e) => PostLike.fromJson(e)!)
                .toList() ??
            [],
        commentsCount: JsonUtils.getCountInput(json['comments_count']),
        likesCount: JsonUtils.getCountInput(json['likes_count']),
      );
    } catch (err) {
      print('Post.fromJson - $err');
      rethrow;
    }
  }
}
