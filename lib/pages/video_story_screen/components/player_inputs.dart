import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/assets_path.dart';
import 'package:video_player/video_player.dart';

class PlayerInputs extends StatefulWidget {
  const PlayerInputs({
    Key? key,
    required this.videoController,
    this.foregroundColor = TheoColors.secondary,
    this.textColor = TheoColors.secondary,
    this.playButtonColor,
    this.maximizeButton = true,
  }) : super(key: key);

  @override
  _PlayerInputsState createState() => _PlayerInputsState();

  final VideoPlayerController videoController;
  final Color foregroundColor;
  final Color textColor;
  final Color? playButtonColor;
  final bool maximizeButton;
}

class _PlayerInputsState extends State<PlayerInputs> {
  @override
  void initState() {
    super.initState();

    widget.videoController.addListener(_handleVideoChanges);
  }

  String _passedTime = '0:00';
  String _timeLeft = '- 0:00';
  final double _iconSize = 27;

  Future<void> _handleVideoChanges() async {
    if (!widget.videoController.value.isPlaying) return;

    var position = await widget.videoController.position;
    var totalDuration = widget.videoController.value.duration;

    setState(() {
      _passedTime = _getVideoTime(position);

      if (position != null) {
        _timeLeft = '- ${_getVideoTime(totalDuration - position)}';
      }
    });
  }

  String _getVideoTime(Duration? time) {
    if (time != null) {
      var minutes = time.inSeconds ~/ 60;

      var seconds = time.inSeconds - (minutes * 60);

      return '$minutes:$seconds';
    }

    return '0:00';
  }

  void _maximizeButtonTap() {}

  Future<void> _replayButtonTap(int seconds) async {
    var position = await widget.videoController.position;

    await widget.videoController.seekTo(position! + Duration(seconds: seconds));
  }

  void _repeateButtonTap() {
    widget.videoController.setLooping(!widget.videoController.value.isLooping);
  }

  void _playButtonTap() {
    if (widget.videoController.value.isPlaying) {
      widget.videoController.pause();
    } else {
      widget.videoController.play();
    }
  }

  @override
  void dispose() {
    super.dispose();

    widget.videoController.removeListener(_handleVideoChanges);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _bar,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _maximizeButton,
              _leftReplayButton,
              _playButton,
              _rightReplayButton,
              _repeateButton,
            ],
          ),
        ],
      ),
    );
  }

  Widget get _maximizeButton => IconButton(
        icon: Icon(
          FeatherIcons.maximize2,
          color: widget.maximizeButton
              ? widget.foregroundColor
              : TheoColors.twelve,
        ),
        onPressed: widget.maximizeButton ? _maximizeButtonTap : null,
        iconSize: _iconSize,
      );

  Widget get _leftReplayButton => IconButton(
        icon: SvgPicture.asset(
          AssetsPath.leftReplay,
          color: widget.foregroundColor,
        ),
        onPressed: () => _replayButtonTap(-10),
        iconSize: _iconSize,
      );

  Widget get _playButton => IconButton(
        icon: Container(
          decoration: BoxDecoration(
            color: TheoColors.secondary,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(13),
          child: Container(
            margin: EdgeInsets.only(left: 2),
            child: SvgPicture.asset(
              AssetsPath.playSvg,
              color: widget.playButtonColor,
            ),
          ),
        ),
        onPressed: _playButtonTap,
        iconSize: 50,
      );
  Widget get _rightReplayButton => IconButton(
        icon: SvgPicture.asset(
          AssetsPath.rightReplay,
          color: widget.foregroundColor,
        ),
        onPressed: () => _replayButtonTap(10),
        iconSize: _iconSize,
      );
  Widget get _repeateButton => IconButton(
        icon: Icon(
          FeatherIcons.repeat,
          color: widget.foregroundColor,
        ),
        onPressed: _repeateButtonTap,
        iconSize: _iconSize,
      );

  Widget get _bar => Container(
        child: Column(
          children: [
            VideoProgressIndicator(
              widget.videoController,
              allowScrubbing: true,
              colors: VideoProgressColors(
                backgroundColor: TheoColors.twentySix,
                playedColor: widget.foregroundColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _passedTime,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: widget.textColor,
                      ),
                ),
                Text(
                  _timeLeft,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: widget.textColor,
                      ),
                ),
              ],
            )
          ],
        ),
      );
}
