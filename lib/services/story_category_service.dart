import 'package:supabase/supabase.dart' as sup;

import 'api_client.dart';

class StoryCategoryService {
  StoryCategoryService(this.client);

  final APIClient client;

  Future<sup.PostgrestResponse?> fetchStoryCategories() async {
    // ignore: prefer_single_quotes
    var response = await client.supabase.from('story_categories').select("""
        *, 
        image: image_id (*)
        """).execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    return response;
  }
}
