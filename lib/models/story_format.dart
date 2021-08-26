import 'dart:convert';

class StoryFormat {
  StoryFormat({this.id, this.name, this.displayName});

  String? id;
  String? name;

  // pt, en, es
  Map<String, dynamic>? displayName;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'display_name': json.encode(displayName),
      };

  static StoryFormat? fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData == null) return null;

    try {
      return StoryFormat(
        id: jsonData['id'],
        name: jsonData['name'],
        displayName: jsonData['display_name'],
      );
    } catch (err) {
      print('StoryFormat.fromJson - $err');
      rethrow;
    }
  }
}
