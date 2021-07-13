import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnv {
  static String? get SUPABASE_URL => dotenv.env['SUPABASE_URL'];
  static String? get SUPABASE_KEY => dotenv.env['SUPABASE_KEY'];
}
