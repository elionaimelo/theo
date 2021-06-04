import 'package:mobx/mobx.dart';
part 'concluded_screen_controller.g.dart';

class ConcludedScreenController = _ConcludedScreenControllerBase
    with _$ConcludedScreenController;

abstract class _ConcludedScreenControllerBase with Store {
  _ConcludedScreenControllerBase({
    this.withAvaliations = false,
    this.progress,
    this.total,
    required this.message,
    required this.title,
    required this.onNextButtonTap,
  });

  final String message;
  final String title;
  final bool withAvaliations;
  int? progress;
  int? total;
  final Function() onNextButtonTap;

  bool get withProgress => progress != null && total != null;
}
