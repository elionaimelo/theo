import 'package:theo/models/user.dart';
import 'package:theo/services/api_client.dart';

class UserService {
  UserService(this.client);

  final APIClient client;

  Future<User?> getUser({required String email}) async {
    // ignore: prefer_single_quotes
    var query = await client.supabase.from('users').select("""
        *, 
        profile: profile_id (*),
        role: role_id (*)
        """).eq('email', email).execute();

    if (query.error != null) {
      throw Exception(query.error!.message);
    }

    var user = User.fromJson(query.data.first);

    return user;
  }
}
