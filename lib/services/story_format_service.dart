import 'package:supabase/supabase.dart' as sup;

import 'api_client.dart';

class StoryFormatService {
  StoryFormatService(this.client);

  final APIClient client;

  Future<sup.PostgrestResponse?> fetchStoryFormats() async {
    // ignore: prefer_single_quotes
    var response = await client.supabase.from('story_formats').select("""
        *
        """).execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    return response;
  }
}
