import 'package:theo/models/story.dart';

class Image {
  Image({this.id, this.url, this.storyId, this.story});

  String? id;
  String? url;
  String? storyId;

  Story? story;

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'image_id': storyId,
      };

  static Image? fromJson(Map<String, dynamic> json) {
    try {
      return Image(
        id: json['id'],
        url: json['url'],
        storyId: json['story_id'],
      );
    } catch (err) {
      print('Image.fromJson - $err');
    }
  }
}
