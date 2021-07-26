class PostLike {
  PostLike({
    this.id,
    this.userId,
    this.postId,
  });

  String? id;
  String? userId;
  String? postId;

  Map<String, dynamic> toJson({bool withId = true}) => {
        if (withId) 'id': id,
        'user_id': userId,
        'post_id': postId,
      };

  static PostLike? fromJson(Map<String, dynamic> json) {
    try {
      return PostLike(
        id: json['id'],
        userId: json['user_id'],
        postId: json['post_id'],
      );
    } catch (err) {
      print('PostLike.fromJson - $err');
      rethrow;
    }
  }
}
