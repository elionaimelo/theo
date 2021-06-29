import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:video_player/video_player.dart';

class AudioButton extends StatefulWidget {
  const AudioButton(
      {Key? key, required this.controller, required this.foregroundColor})
      : super(key: key);

  @override
  _AudioButtonState createState() => _AudioButtonState();

  final VideoPlayerController controller;

  final Color foregroundColor;
}

class _AudioButtonState extends State<AudioButton> {
  bool isMuted = false;

  void _volumeButton() {
    setState(() {
      isMuted = !isMuted;
    });
    widget.controller.setVolume(isMuted ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isMuted ? FeatherIcons.volumeX : FeatherIcons.volume2,
        color: widget.foregroundColor,
        size: 30,
      ),
      onPressed: _volumeButton,
    );
  }
}
