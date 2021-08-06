import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:theo/models/post.dart';
import 'package:theo/services/file_service.dart';
import 'package:theo/types/enums.dart';
import 'package:video_player/video_player.dart';
part 'discover_media_screen_controller.g.dart';

class DiscoverMediaScreenController = _DiscoverMediaScreenControllerBase
    with _$DiscoverMediaScreenController;

abstract class _DiscoverMediaScreenControllerBase with Store {
  _DiscoverMediaScreenControllerBase({required this.post});

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
      errorMessage = err.toString();
      eResultStatus = EResultStatus.REQUEST_ERROR;
    }
  }
}
