import 'package:theo/models/language.dart';

class Profile {
  Profile({
    this.id,
    this.name,
    this.country,
    this.age,
    this.language,
    this.languageId,
  });

  String? id;
  String? name;
  String? country;
  int? age;
  String? languageId;
  Language? language;

  Map<String, dynamic> toJson({bool withId = true}) => {
        if (withId) 'id': id,
        'name': name,
        'country': country,
        'age': age,
        'language_id': languageId,
      };

  static Profile? fromJson(Map<String, dynamic> json) {
    try {
      return Profile(
        id: json['id'],
        name: json['name'],
        country: json['country'],
        age: json['age'],
        languageId: json['language_id'],
      );
    } catch (err) {
      print('Profile.fromJson - $err');
    }
  }
}
