import 'package:flutter/material.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/core/constants/story_format_consts.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/utils/assets_path.dart';
import 'package:video_player/video_player.dart';

import 'components/player_inputs.dart';
import 'components/video_top_bar.dart';
import 'media_story_screen_controller.dart';

class MediaStoryScreen extends StatefulWidget {
  const MediaStoryScreen({Key? key, required this.controller})
      : super(key: key);

  @override
  _MediaStoryScreenState createState() => _MediaStoryScreenState();

  final MediaStoryScreenController controller;
}

class _MediaStoryScreenState extends State<MediaStoryScreen> {
  @override
  void initState() {
    super.initState();

    widget.controller.videoController.initialize();
  }

  @override
  void dispose() {
    widget.controller.videoController.pause();
    widget.controller.videoController.dispose();
    super.dispose();
  }

  void _bottomButtonTap() {
    widget.controller.storyStore
        .finishLearningStory(widget.controller.story.id!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: AppBar().preferredSize.height),
      color: _backgroundColor,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              padding: TheoMetrics.paddingScreen.copyWith(top: 0, bottom: 0),
              child: VideoTopBar(
                controller: widget.controller.videoController,
                foregroundColor: _foregroundColor,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                _video,
                Container(
                  margin: EdgeInsets.only(bottom: 58),
                ),
                _bottomContent,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _bottomContent => Container(
        padding: TheoMetrics.paddingScreen.copyWith(top: 0, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _videoTitle,
            Container(
              margin: EdgeInsets.only(bottom: 21),
            ),
            _player,
            Container(
              margin: EdgeInsets.only(bottom: 50),
            ),
            _bottomButton,
            Container(
              margin: EdgeInsets.only(bottom: 34),
            )
          ],
        ),
      );

  Widget get _video => _isPodcast
      ? Container(
          child: Image(
            image: AssetImage(AssetsPath.podcastPng),
          ),
        )
      : Container(
          child: Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayer(widget.controller.videoController),
            ),
          ),
        );

  Widget get _videoTitle => Container(
        child: Text(
          widget.controller.story.title!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                color: _textColor,
                fontWeight: FontWeight.w700,
              ),
        ),
      );

  bool get _isPodcast =>
      widget.controller.story.format!.name == StoryFormatConsts.PODCAST;

  Widget get _player => PlayerInputs(
        videoController: widget.controller.videoController,
        foregroundColor: _foregroundColor,
        playButtonColor: _playButtonColor,
        textColor: _textColor,
        maximizeButton: _isVideoFormat,
      );

  Widget get _bottomButton => BottomButton(
        text: 'Feito!',
        onPressed: () => _bottomButtonTap(),
        backgroundColor: Colors.transparent,
        primaryColor: _foregroundColor,
        borderColor: _foregroundColor,
      );

  Color get _backgroundColor =>
      _isVideoFormat ? Colors.black : TheoColors.secondary;

  Color get _foregroundColor =>
      _isVideoFormat ? TheoColors.secondary : TheoColors.primary;

  Color get _textColor =>
      _isVideoFormat ? TheoColors.secondary : TheoColors.seven;

  bool get _isVideoFormat =>
      widget.controller.story.format!.name == StoryFormatConsts.VIDEO;

  Color? get _playButtonColor => _isVideoFormat ? null : TheoColors.primary;
}
