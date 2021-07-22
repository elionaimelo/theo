import 'package:supabase/supabase.dart' as sup;

import 'api_client.dart';

class PostService {
  PostService(this.client);

  final APIClient client;

  Future<sup.PostgrestResponse?> fetchPosts() async {
    var response = await client.supabase.from('posts').select().execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    return response;
  }
}
