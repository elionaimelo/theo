import 'dart:convert';

class Role {
  Role({this.id, this.name, this.displayName});

  String? id;
  String? name;

  // pt, en, es
  Map<String, dynamic>? displayName;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'display_name': json.encode(displayName),
      };

  static Role? fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData == null) return null;

    try {
      return Role(
        id: jsonData['id'],
        name: jsonData['name'],
        displayName: jsonData['display_name'] as Map<String, dynamic>,
      );
    } catch (err) {
      print('Role.fromJson - $err');
      rethrow;
    }
  }
}
