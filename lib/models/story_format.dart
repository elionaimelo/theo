import 'package:theo/core/constants/story_format_consts.dart';

class StoryFormat {
  StoryFormat({this.id, this.name});

  String? id;
  String? name;

  String get displayName {
    switch (name) {
      case StoryFormatConsts.VIDEO:
        return 'Vídeo';
      case StoryFormatConsts.GAME:
        return 'Jogo';
      case StoryFormatConsts.IMAGE:
        return 'Imagem';
      case StoryFormatConsts.ANIMATION:
        return 'Animação';
      case StoryFormatConsts.HQ:
        return 'HQ';
      case StoryFormatConsts.INTERACTIVE_FIGURE:
        return 'Figura Interativa';
      case StoryFormatConsts.PODCAST:
        return 'Podcast';
      case StoryFormatConsts.INFROGRAPHIC:
        return 'Infográfico';
      case StoryFormatConsts.TEXT:
        return 'Texto';
      case StoryFormatConsts.QUIZ:
        return 'Quiz';
      case StoryFormatConsts.MUSIC:
        return 'Música';
      default:
        return '';
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  static StoryFormat? fromJson(Map<String, dynamic> json) {
    try {
      return StoryFormat(
        id: json['id'],
        name: json['name'],
      );
    } catch (err) {
      print('StoryFormat.fromJson - $err');
    }
  }
}
