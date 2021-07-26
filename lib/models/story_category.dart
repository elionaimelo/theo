import 'package:theo/models/file.dart';

class StoryCategory {
  StoryCategory({this.id, this.name, this.imageId, this.imageFile});

  String? id;
  String? name;
  String? imageId;

  File? imageFile;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image_file_id': imageId,
      };

  static StoryCategory? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    try {
      return StoryCategory(
        id: json['id'],
        name: json['name'],
        imageId: json['image_id'],
        imageFile: File.fromJson(json['image_file']),
      );
    } catch (err) {
      print('StoryCategory.fromJson - $err');
      rethrow;
    }
  }
}
