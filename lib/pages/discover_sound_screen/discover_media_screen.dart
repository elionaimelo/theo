import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:theo/components/adult_content_tag.dart';
import 'package:theo/components/audio_button.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/components/lazy_image.dart';
import 'package:theo/components/post_card_actions.dart';
import 'package:theo/components/profile_bar.dart';
import 'package:theo/components/result_status/loading_status.dart';
import 'package:theo/components/story_app_bar.dart';
import 'package:theo/core/constants/story_format_consts.dart';
import 'package:theo/pages/discover_sound_screen/discover_media_screen_controller.dart';
import 'package:theo/pages/media_story_screen/components/player_inputs.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/types/enums.dart';
import 'package:theo/utils/assets_path.dart';
import 'package:video_player/video_player.dart';

class DiscoverMediaScreen extends StatefulWidget {
  const DiscoverMediaScreen({Key? key, required this.controller})
      : super(key: key);

  @override
  _DiscoverMediaScreenState createState() => _DiscoverMediaScreenState();

  final DiscoverMediaScreenController controller;
}

class _DiscoverMediaScreenState extends State<DiscoverMediaScreen> {
  @override
  void initState() {
    super.initState();

    widget.controller.fetchMediaUrl();
  }

  @override
  void deactivate() {
    super.deactivate();

    widget.controller.videoController.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TheoColors.secondary,
      padding: TheoMetrics.paddingScreenWithTopMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: StoryAppBar(),
              ),
              AudioButton(
                controller: widget.controller.videoController,
                foregroundColor: TheoColors.primary,
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
          ),
          ProfileBar(
            avatarImage: AssetsPath.avatarJpg,
            name: widget.controller.post.user?.profile?.name ?? '-',
          ),
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 12),
            child: _author,
          ),
          if (widget.controller.post.story?.adultContent! ?? false)
            AdultContentTag(),
          Container(
            margin: EdgeInsets.only(top: 45),
          ),
          _playerBody,
          PostCardActions(
            likesCount: widget.controller.post.likesCount,
            commentsCount: widget.controller.post.commentsCount,
          ),
        ],
      ),
    );
  }

  Widget get _playerBody {
    return Observer(
      builder: (_) {
        if (widget.controller.eResultStatus == EResultStatus.LOADING) {
          return Expanded(child: LoadingStatus());
        } else if (widget.controller.eResultStatus ==
            EResultStatus.REQUEST_ERROR) {
          return ErrorAlertDialog(
            content: widget.controller.errorMessage,
            withButton: false,
          );
        }

        return Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _playerView,
                _audioTitle,
                PlayerInputs(
                  videoController: widget.controller.videoController,
                  foregroundColor: TheoColors.primary,
                  playButtonColor: TheoColors.primary,
                  textColor: TheoColors.seven,
                  maximizeButton: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget get _playerView {
    var defaultImage = _isPodcast
        ? AssetImage(AssetsPath.podcastPng)
        : AssetImage(AssetsPath.discoverMusic);

    if (widget.controller.post.story?.format?.name != StoryFormatConsts.VIDEO) {
      return Expanded(
        child: Container(
          child: LazyImage(
            file: widget.controller.post.thumbnailImage,
            defaultImage: defaultImage,
          ),
        ),
      );
    }

    return Expanded(
      child: Container(
        child: Center(
          child: AspectRatio(
            aspectRatio: widget.controller.videoController.value.aspectRatio,
            child: VideoPlayer(widget.controller.videoController),
          ),
        ),
      ),
    );
  }

  Widget get _audioTitle => Container(
        child: Text(
          widget.controller.post.story?.title! ?? '-',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                color: TheoColors.six,
                fontWeight: FontWeight.w700,
              ),
        ),
      );

  Widget get _author => Text(
        widget.controller.post.story?.author! ?? '-',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 14,
              color: TheoColors.seven,
            ),
      );

  bool get _isPodcast =>
      widget.controller.post.story?.format!.name == StoryFormatConsts.PODCAST;
}
