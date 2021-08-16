import 'package:supabase/supabase.dart' as sup;
import 'package:theo/core/dot_env.dart';
import 'package:theo/services/auth_service.dart';
import 'package:theo/services/file_service.dart';
import 'package:theo/services/language_service.dart';
import 'package:theo/services/post_service.dart';
import 'package:theo/services/role_service.dart';
import 'package:theo/services/story_category_service.dart';
import 'package:theo/services/story_format_service.dart';
import 'package:theo/services/story_service.dart';
import 'package:theo/services/user_service.dart';
import 'package:theo/values/error_messages.dart';

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

  StoryCategoryService get storyCategoryService => StoryCategoryService(this);

  PostService get postService => PostService(this);

  StoryFormatService get storyFormatService => StoryFormatService(this);

  FileService get fileService => FileService(this);

  StoryService get storyService => StoryService(this);

  UserService get userService => UserService(this);
}
