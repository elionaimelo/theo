import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnv {
  static String? get SUPABASE_URL => dotenv.env['SUPABASE_URL'];
  static String? get SUPABASE_KEY => dotenv.env['SUPABASE_KEY'];
  static String? get SUPABASE_BUCKET_NAME => dotenv.env['SUPABASE_BUCKET_NAME'];
  static String? get SUPABASE_BUCKET_IMAGE_PATH =>
      dotenv.env['SUPABASE_BUCKET_IMAGE_PATH'];
  static String? get SUPABASE_BUCKET_FILE_PATH =>
      dotenv.env['SUPABASE_BUCKET_FILE_PATH'];
  static String? get SUPABASE_BUCKET_VIDEO_PATH =>
      dotenv.env['SUPABASE_BUCKET_VIDEO_PATH'];
}
