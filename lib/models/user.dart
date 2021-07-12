import 'package:theo/models/profile.dart';
import 'package:theo/models/role.dart';

class User {
  User({
    this.id,
    this.email,
    this.termAccepted,
    this.canceled,
    this.roleId,
    this.profileId,
    this.role,
    this.profile,
  });

  String? id;
  String? email;
  bool? termAccepted;
  bool? canceled;
  String? roleId;
  String? profileId;
  Role? role;
  Profile? profile;

  Map<String, dynamic> toJson({bool withId = true}) => {
        if (withId) 'id': id,
        'email': email,
        'term_accepted': termAccepted,
        'canceled': canceled,
        'role_id': roleId,
        'profile_id': profileId
      };

  static User? fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: json['id'],
        email: json['email'],
        canceled: json['canceled'],
        termAccepted: json['term_accepted'],
        roleId: json['role_id'],
        profileId: json['profile_id'],
      );
    } catch (err) {
      print('User.fromJson - $err');
    }
  }
}
