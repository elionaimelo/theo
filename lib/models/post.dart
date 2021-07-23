import 'package:theo/models/file.dart';
import 'package:theo/models/post_commnet.dart';
import 'package:theo/models/post_likes.dart';
import 'package:theo/models/story.dart';
import 'package:theo/models/user.dart';

class Post {
  Post({
    this.id,
    this.userId,
    this.storyId,
    this.user,
    this.story,
    this.comments = const [],
    this.likes = const [],
  });

  String? id;
  String? userId;
  String? storyId;

  User? user;
  Story? story;

  List<PostComment> comments;
  List<PostLike> likes;

  File? get thumbnailImage {
    if (story == null) return null;

    if (story!.imageFiles.isEmpty) return null;

    return story!.imageFiles.first;
  }

  Map<String, dynamic> toJson({bool withId = true}) => {
        if (withId) 'id': id,
        'user_id': userId,
        'story_id': storyId,
      };

  static Post? fromJson(Map<String, dynamic> json) {
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
      );
    } catch (err) {
      print('Post.fromJson - $err');
      rethrow;
    }
  }
}
