import 'package:mobx/mobx.dart';
import 'package:theo/models/post.dart';
import 'package:theo/types/enums.dart';
part 'discover_image_screen_controller.g.dart';

class DiscoverImageScreenController = _DiscoverImageScreenControllerBase
    with _$DiscoverImageScreenController;

abstract class _DiscoverImageScreenControllerBase with Store {
  _DiscoverImageScreenControllerBase({required this.post});

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @observable
  String errorMessage = '';
  final Post post;
}
