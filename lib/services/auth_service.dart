import 'package:supabase/supabase.dart' as sup;
import 'package:theo/core/dot_env.dart';
import 'package:theo/models/language.dart';
import 'package:theo/models/profile.dart';
import 'package:theo/models/user.dart';
import 'package:theo/services/api_client.dart';

class AuthService {
  AuthService(this.client);

  final APIClient client;

  Future<sup.PostgrestResponse?> signUp({
    required User user,
    required String password,
  }) async {
    try {
      var result = await client.supabase.auth.signUp(user.email!, password);

      if (result.error != null) {
        throw Exception(result.error!.message);
      }

      var profileResponse = await client.supabase
          .from('profiles')
          .insert([user.profile!.toJson(withId: false)]).execute();

      var prof = Profile.fromJson(profileResponse.data.first)!;

      user.profileId = prof.id;

      var insertResponse = await client.supabase
          .from('users')
          .insert([user.toJson(withId: false)]).execute();

      return insertResponse;
    } catch (err) {
      print('AuthService.signUp - $err');
    }
  }

  Future<List?> signIn(
      {required String email, required String password}) async {
    try {
      var result =
          await client.supabase.auth.signIn(email: email, password: password);

      if (result.error != null) {
        throw Exception(result.error!.message);
      }

      var query = await client.supabase
          .from('users')
          .select()
          .eq('email', email)
          .execute();

      var user = User.fromJson(query.data.first);

      query = await client.supabase
          .from('profiles')
          .select()
          .eq('id', user!.profileId)
          .execute();

      user.profile = Profile.fromJson(query.data.first);

      return [result.data, user];
    } catch (err) {
      print('AuthService.signUp - $err');
    }
  }

  Future<void> logout() async {}
}
