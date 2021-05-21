import 'package:flutter/material.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/pages/video_learn_screen/components/player_inputs.dart';
import 'package:theo/pages/video_learn_screen/components/video_top_bar.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:video_player/video_player.dart';

class VideoLearnScreen extends StatefulWidget {
  @override
  _VideoLearnScreenState createState() => _VideoLearnScreenState();
}

class _VideoLearnScreenState extends State<VideoLearnScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: AppBar().preferredSize.height),
      color: Colors.black,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              padding: TheoMetrics.paddingScreen.copyWith(top: 0, bottom: 0),
              child: VideoTopBar(
                controller: _controller,
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

  Widget get _video => Container(
        child: Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoPlayer(_controller),
          ),
        ),
      );

  Widget get _videoTitle => Container(
        child: Text(
          'Storyteling e lorem ipsum dolor sit amet',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                color: TheoColors.secondary,
              ),
        ),
      );

  Widget get _player => PlayerInputs(
        videoController: _controller,
      );

  Widget get _bottomButton => BottomButton(
        text: 'Feito!',
        onPressed: () => Navigator.of(context).pop(),
        backgroundColor: Colors.transparent,
        primaryColor: TheoColors.secondary,
        borderColor: TheoColors.secondary,
      );
}
