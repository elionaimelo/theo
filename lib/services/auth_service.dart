import 'package:theo/models/profile.dart';
import 'package:theo/models/user.dart';
import 'package:theo/services/api_client.dart';

class AuthService {
  AuthService(this.client);

  final APIClient client;

  Future<List?> signUp({
    required User user,
    required String password,
  }) async {
    var profileResponse = await client.supabase
        .from('profiles')
        .insert([user.profile!.toJson(withId: false)]).execute(); 

    if (profileResponse.error != null) {
      throw Exception(profileResponse.error!.message);
    }

    var prof = Profile.fromJson(profileResponse.data.first)!;

    user.profileId = prof.id;

    var insertResponse = await client.supabase
        .from('users')
        .insert([user.toJson(withId: false)]).execute();

    if (insertResponse.error != null) {
      throw Exception(insertResponse.error!.message);
    }

    var result = await client.supabase.auth.signUp(user.email!, password);

    if (result.error != null) {
      throw Exception(result.error!.message);
    }

    var newUser = await client.userService.getUser(email: user.email!);

    return [result.data, newUser];
  }

  Future<List?> signIn(
      {required String email, required String password}) async {
    var result =
        await client.supabase.auth.signIn(email: email, password: password);

    if (result.error != null) {
      throw Exception(result.error!.message);
    }

    var user = await client.userService.getUser(email: email);

    return [result.data, user];
  }

  Future<void> logout() async {}
}
