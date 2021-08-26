import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:theo/models/post.dart';
import 'package:theo/services/file_service.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/types/enums.dart';
import 'package:theo/values/error_messages.dart';
import 'package:video_player/video_player.dart';
part 'discover_media_screen_controller.g.dart';

class DiscoverMediaScreenController = _DiscoverMediaScreenControllerBase
    with _$DiscoverMediaScreenController;

abstract class _DiscoverMediaScreenControllerBase with Store {
  _DiscoverMediaScreenControllerBase(
      {required this.post, required this.navigationStore});

  final NavigationStore navigationStore;

  VideoPlayerController videoController = VideoPlayerController.network('');

  final Post post;

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @observable
  String errorMessage = '';

  @observable
  String mediaUrl = '';

  @action
  Future<void> fetchMediaUrl() async {
    try {
      eResultStatus = EResultStatus.LOADING;

      mediaUrl = (await post.mediaFile!.getUrl(
        FileService(
          GetIt.I.get(),
        ),
      ))!;

      videoController = VideoPlayerController.network(
        mediaUrl,
      );

      await videoController.initialize();

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      errorMessage =
          ErrorMessages.of(navigationStore.currentContext).RESQUEST_ERROR;
      eResultStatus = EResultStatus.REQUEST_ERROR;
    }
  }
}
