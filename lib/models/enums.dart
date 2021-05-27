enum EStoryFormat { VIDEO, PODCAST, INFROGRAPHIC, TEXT, QUIZ, NONE }
enum EStoryType { LEARNING, POST, NONE }

extension EStoryFormatExtension on EStoryFormat {
  String get displayName {
    switch (this) {
      case EStoryFormat.VIDEO:
        return 'Vídeo';
      case EStoryFormat.INFROGRAPHIC:
        return 'Infográfico';
      case EStoryFormat.PODCAST:
        return 'Podcast';
      case EStoryFormat.QUIZ:
        return 'Quiz';
      case EStoryFormat.TEXT:
        return 'Texto';
      default:
        return '';
    }
  }
}