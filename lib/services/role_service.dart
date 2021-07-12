import 'package:theo/models/role.dart';
import 'package:supabase/supabase.dart' as sup;

import 'api_client.dart';

class RoleService {
  RoleService(this.client);

  final APIClient client;

  Future<sup.PostgrestResponse?> fetchRoles() async {
    var response = await client.supabase.from('roles').select().execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    return response;
  }
}
