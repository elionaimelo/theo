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
  String _textTimeLeft = '- 0:00';
  final double _iconSize = 27;
  bool isLooping = false;
  bool isCompleteOrPaused = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> _handleVideoChanges() async {
    if (!widget.videoController.value.isPlaying) return;

    var position = widget.videoController.value.position;
    var timeLeft = _formatVideoTime(_getTimeLeft());

    var passedTime = _formatVideoTime(position);

    setState(() {
      _passedTime = passedTime;
      _textTimeLeft = timeLeft;
    });
  }

  String _formatVideoTime(Duration? time) {
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

    setState(() {
      isLooping = widget.videoController.value.isLooping;
    });
  }

  Future<void> _playButtonTap() async {
    var timeLeft = _getTimeLeft();
    if (widget.videoController.value.isPlaying && timeLeft > Duration.zero) {
      await widget.videoController.pause();

      setState(() {
        isCompleteOrPaused = true;
      });
    } else {
      if (timeLeft <= Duration.zero) {
        await widget.videoController.seekTo(Duration.zero);
      }
      await widget.videoController.play();

      setState(() {
        isCompleteOrPaused = false;
      });
    }
  }

  Duration _getTimeLeft() {
    var position = widget.videoController.value.position;
    var totalDuration = widget.videoController.value.duration;

    return totalDuration - position;
  }

  @override
  void dispose() {
    widget.videoController.removeListener(_handleVideoChanges);
    super.dispose();
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
          child: _playButtonIcon,
        ),
        onPressed: _playButtonTap,
        iconSize: 60,
      );

  Widget get _playButtonIcon => isCompleteOrPaused
      ? Container(
          margin: EdgeInsets.only(left: 2),
          child: SvgPicture.asset(
            AssetsPath.playSvg,
            color: widget.playButtonColor,
          ),
        )
      : Container(
          child: Center(
            child: Icon(
              FeatherIcons.pause,
              color: widget.playButtonColor,
              size: 35,
            ),
          ),
        );

  Widget get _rightReplayButton => IconButton(
        icon: SvgPicture.asset(
          AssetsPath.rightReplay,
          color: widget.foregroundColor,
        ),
        onPressed: () => _replayButtonTap(10),
        iconSize: _iconSize,
      );

  Widget get _repeateButton => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isLooping
              ? widget.foregroundColor.withAlpha(70)
              : Colors.transparent,
        ),
        child: IconButton(
          icon: Icon(
            FeatherIcons.repeat,
            color: widget.foregroundColor,
          ),
          onPressed: _repeateButtonTap,
          iconSize: _iconSize,
        ),
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
                  _textTimeLeft,
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
