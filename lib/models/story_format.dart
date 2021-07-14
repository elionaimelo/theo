class StoryFormat {
  StoryFormat({this.name});

  String? name;

  String get displayName {
    switch (name) {
      case 'VIDEO':
        return 'Vídeo';
      case 'INFROGRAPHIC':
        return 'Infográfico';
      case 'PODCAST':
        return 'Podcast';
      case 'MUSIC':
        return 'Música';
      case 'QUIZ':
        return 'Quiz';
      case 'TEXT':
        return 'Texto';
      default:
        return '';
    }
  }
}
