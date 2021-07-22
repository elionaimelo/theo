import 'package:theo/models/story.dart';
import 'package:theo/models/user.dart';

class Post {
  Post({
    this.id,
    this.userId,
    this.storyId,
    this.user,
    this.story,
  });

  String? id;
  String? userId;
  String? storyId;

  User? user;
  Story? story;

  Map<String, dynamic> toJson() => {
        'id': id,
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
      );
    } catch (err) {
      print('Post.fromJson - $err');
    }
  }
}
