import 'package:mobx/mobx.dart';
part 'tutorial_screen_controller.g.dart';

class TutorialScreenController = _TutorialScreenControllerBase
    with _$TutorialScreenController;

abstract class _TutorialScreenControllerBase with Store {
  _TutorialScreenControllerBase({this.onSkipButtonTap});

  final Function()? onSkipButtonTap;
}
