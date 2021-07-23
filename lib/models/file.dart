import 'package:theo/core/constants/file_consts.dart';
import 'package:theo/core/dot_env.dart';
import 'package:theo/models/story.dart';
import 'package:theo/services/file_service.dart';

class File {
  File({this.id, this.ext, this.storyId, this.story});

  String? id;
  String? ext;
  String? storyId;

  Story? story;

  String? get name {
    if (id != null && ext != null) {
      return id! + '.' + ext!;
    }

    return null;
  }

  String? get type {
    if (ext == null) return null;

    switch (ext) {
      case 'png':
      case 'jpg':
      case 'jpeg':
        return FileConsts.IMG_TYPE;
      case 'mp4':
      case 'wmv':
      case 'mkv':
        return FileConsts.VIDEO_TYPE;
      default:
        return FileConsts.OTHER_TYPE;
    }
  }

  String? get bucketPath {
    if (type == null || name == null) return null;

    if (type == FileConsts.IMG_TYPE) {
      return DotEnv.SUPABASE_BUCKET_IMAGE_PATH! + '/' + name!;
    } else if (type == FileConsts.VIDEO_TYPE) {
      return DotEnv.SUPABASE_BUCKET_VIDEO_PATH! + '/' + name!;
    } else if (type == FileConsts.OTHER_TYPE) {
      return DotEnv.SUPABASE_BUCKET_FILE_PATH! + '/' + name!;
    }
  }

  Future<String?> getUrl(FileService service) async {
    return service.getFileSignedUrl(this);
  }

  Map<String, dynamic> toJson({bool withId = true}) => {
        if (withId) 'id': id,
        'ext': ext,
        'story_id': storyId,
      };

  static File? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    try {
      return File(
        id: json['id'],
        ext: json['ext'],
        storyId: json['story_id'],
      );
    } catch (err) {
      print('File.fromJson - $err');
      rethrow;
    }
  }
}
