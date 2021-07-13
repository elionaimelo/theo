class Role {
  Role({this.id, this.name, this.displayName});

  String? id;
  String? name;
  String? displayName;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'display_name': displayName,
      };

  static Role? fromJson(Map<String, dynamic> json) {
    try {
      return Role(
        id: json['id'],
        name: json['name'],
        displayName: json['display_name'],
      );
    } catch (err) {
      print('Role.fromJson - $err');
    }
  }
}
