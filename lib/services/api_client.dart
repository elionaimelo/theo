import 'package:supabase/supabase.dart' as sup;
import 'package:theo/core/dot_env.dart';
import 'package:theo/services/auth_service.dart';
import 'package:theo/services/language_service.dart';
import 'package:theo/services/role_service.dart';

class APIClient {
  late sup.SupabaseClient _supabaseClient;

  APIClient() {
    try {
      if (DotEnv.SUPABASE_KEY == null || DotEnv.SUPABASE_URL == null) {
        throw Exception('API() - Variáveis Env Nulas');
      }

      _supabaseClient =
          sup.SupabaseClient(DotEnv.SUPABASE_URL!, DotEnv.SUPABASE_KEY!);
    } catch (err) {
      print('APIClient() - $err');
    }
  }

  sup.SupabaseClient get supabase => _supabaseClient;

  AuthService get authService => AuthService(this);

  RoleService get roleService => RoleService(this);

  LanguageService get languageService => LanguageService(this);
}