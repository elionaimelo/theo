class Language {
  Language({this.id, this.name, this.displayName});

  String? id;
  String? name;
  String? displayName;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'display_name': displayName,
      };

  static Language? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    try {
      return Language(
        id: json['id'],
        name: json['name'],
        displayName: json['display_name'],
      );
    } catch (err) {
      print('Language.fromJson - $err');
      rethrow;
    }
  }
}
