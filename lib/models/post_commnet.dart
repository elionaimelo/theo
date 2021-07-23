class PostComment {
  PostComment({
    this.id,
    this.userId,
    this.postId,
    this.comment,
  });

  String? id;
  String? userId;
  String? postId;
  String? comment;

  Map<String, dynamic> toJson({bool withId = true}) => {
        if (withId) 'id': id,
        'user_id': userId,
        'post_id': postId,
        'comment': comment,
      };

  static PostComment? fromJson(Map<String, dynamic> json) {
    try {
      return PostComment(
        id: json['id'],
        userId: json['user_id'],
        postId: json['post_id'],
        comment: json['comment'],
      );
    } catch (err) {
      print('PostComment.fromJson - $err');
      rethrow;
    }
  }
}
