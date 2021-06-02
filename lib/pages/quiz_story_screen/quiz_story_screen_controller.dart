import 'package:mobx/mobx.dart';
import 'package:theo/pages/quiz_story_screen/components/answer_input.dart';
part 'quiz_story_screen_controller.g.dart';

class QuizStoryScreenController = _QuizStoryScreenControllerBase
    with _$QuizStoryScreenController;

abstract class _QuizStoryScreenControllerBase with Store {
  @observable
  int tabIndex = 0;

  @observable
  EAnswerInputState eAnswerInputState = EAnswerInputState.NONE;

  @observable
  int selectedAnswer = -1;

  @observable
  int questionsCount = 4;

  @action
  void selectAnswer(int index) {
    selectedAnswer = index;

    if (selectedAnswer == -1) {
      eAnswerInputState = EAnswerInputState.NONE;
    } else {
      eAnswerInputState = EAnswerInputState.SELECTED;
    }
  }

  bool isCorrectAnswer(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return selectedAnswer == 1;
      case 1:
        return selectedAnswer == 0;
      case 2:
        return selectedAnswer == 3;
      case 3:
        return selectedAnswer == 2;
      default:
        return false;
    }
  }
}
