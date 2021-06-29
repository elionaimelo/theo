import 'package:flutter/material.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/models/enums.dart';
import 'package:theo/pages/video_story_screen/components/player_inputs.dart';
import 'package:theo/pages/video_story_screen/components/video_top_bar.dart';
import 'package:theo/pages/video_story_screen/video_story_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/utils/assets_path.dart';
import 'package:video_player/video_player.dart';

class VideoStoryScreen extends StatefulWidget {
  const VideoStoryScreen({Key? key, required this.controller})
      : super(key: key);

  @override
  _VideoStoryScreenState createState() => _VideoStoryScreenState();

  final VideoStoryScreenController controller;
}

class _VideoStoryScreenState extends State<VideoStoryScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
      _isPodcast
          ? 'https://github.com/elionaimelo/theo/raw/pre-validacao/others/audios/revelacast.wav'
          : 'https://github.com/elionaimelo/theo/raw/pre-validacao/others/videos/educacional_celular.mp4',
    );
    _videoController.setLooping(true);
    _videoController.initialize();
  }

  @override
  void dispose() {
    _videoController.pause();
    _videoController.dispose();
    super.dispose();
  }

  void _bottomButtonTap() {
    widget.controller.storyStore.finishStory(widget.controller.story.id);
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
                controller: _videoController,
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

  Widget get _video => widget.controller.story.format == EStoryFormat.VIDEO
      ? Container(
          child: Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayer(_videoController),
            ),
          ),
        )
      : Container(
          child: Image(
            image: AssetImage(AssetsPath.podcastPng),
          ),
        );

  Widget get _videoTitle => Container(
        child: Text(
          _isPodcast
              ? 'Exercício de fortalecimento, fazer ou não fazer'
              : 'Aprendendo a gravar vídeos com o celular',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                color: _textColor,
                fontWeight: FontWeight.w700,
              ),
        ),
      );

  bool get _isPodcast => widget.controller.story.format == EStoryFormat.PODCAST;

  Widget get _player => PlayerInputs(
        videoController: _videoController,
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
      widget.controller.story.format == EStoryFormat.VIDEO;

  Color? get _playButtonColor => _isVideoFormat ? null : TheoColors.primary;
}
