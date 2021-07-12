import 'package:theo/models/role.dart';
import 'package:supabase/supabase.dart' as sup;

import 'api_client.dart';

class LanguageService {
  LanguageService(this.client);

  final APIClient client;

  Future<sup.PostgrestResponse?> fetchLanguages() async {
    try {
      var response = await client.supabase.from('languages').select().execute();

      if (response.error != null) {
        throw Exception(response.error!.message);
      }

      return response;
    } catch (err) {
      print('LanguageService.fetchLanguages - $err');
    }
  }
}
