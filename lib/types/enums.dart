enum EStoryFormat { VIDEO, PODCAST, INFROGRAPHIC, TEXT, QUIZ, NONE, MUSIC }
enum EStoryType { LEARNING, POST, NONE }

extension EStoryFormatExtension on EStoryFormat {
  String getString() {
    return toString().split('.').last;
  }
}

enum ResultStatus {
  NONE,
  LOADING,
  DONE,
  NO_RESULT,
  REQUEST_ERROR,
}
