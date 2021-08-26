import 'dart:convert';

import 'package:theo/models/file.dart';

class StoryCategory {
  StoryCategory({
    this.id,
    this.name,
    this.imageId,
    this.imageFile,
    this.displayName,
  });

  String? id;
  String? name;
  String? imageId;

  // pt, en, es
  Map<String, dynamic>? displayName;

  File? imageFile;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image_file_id': imageId,
        'display_name': json.encode(displayName)
      };

  static StoryCategory? fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData == null) return null;

    try {
      return StoryCategory(
        id: jsonData['id'],
        name: jsonData['name'],
        imageId: jsonData['image_id'],
        displayName: jsonData['display_name'],
        imageFile: File.fromJson(jsonData['image_file']),
      );
    } catch (err) {
      print('StoryCategory.fromJson - $err');
      rethrow;
    }
  }
}
