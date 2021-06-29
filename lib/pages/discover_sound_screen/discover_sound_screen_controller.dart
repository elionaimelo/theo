import 'package:mobx/mobx.dart';
import 'package:theo/models/story.dart';
import 'package:video_player/video_player.dart';
part 'discover_sound_screen_controller.g.dart';

class DiscoverSoundScreenController = _DiscoverSoundScreenControllerBase
    with _$DiscoverSoundScreenController;

abstract class _DiscoverSoundScreenControllerBase with Store {
  _DiscoverSoundScreenControllerBase({required this.story}) {
    videoController = VideoPlayerController.network(story.link);
  }

  late VideoPlayerController videoController;

  final Story story;
}
