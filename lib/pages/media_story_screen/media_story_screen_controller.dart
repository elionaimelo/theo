import 'package:mobx/mobx.dart';
import 'package:theo/models/story.dart';
import 'package:theo/states/story_store.dart';
import 'package:video_player/video_player.dart';
part 'media_story_screen_controller.g.dart';

class MediaStoryScreenController = _MediaStoryScreenControllerBase
    with _$MediaStoryScreenController;

abstract class _MediaStoryScreenControllerBase with Store {
  _MediaStoryScreenControllerBase({
    required this.storyStore,
    required this.story,
  }) {
    videoController = VideoPlayerController.network(story.url!);
  }

  late VideoPlayerController videoController;

  final StoryStore storyStore;

  final Story story;
}
