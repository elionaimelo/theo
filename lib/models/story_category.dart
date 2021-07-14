import 'package:theo/models/image.dart';

class StoryCategory {
  StoryCategory({this.id, this.name, this.imageId, this.image});

  String? id;
  String? name;
  String? imageId;

  Image? image;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image_id': imageId,
      };

  static StoryCategory? fromJson(Map<String, dynamic> json) {
    try {
      return StoryCategory(
        id: json['id'],
        name: json['name'],
        imageId: json['image_id'],
        image: Image.fromJson(json['image']),
      );
    } catch (err) {
      print('StoryCategory.fromJson - $err');
    }
  }
}
