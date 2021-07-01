import 'package:flutter/material.dart';
import 'package:theo/components/audio_button.dart';
import 'package:theo/components/close_top_bar_button.dart';
import 'package:theo/styles/colors.dart';
import 'package:video_player/video_player.dart';

class VideoTopBar extends StatefulWidget {
  VideoTopBar({
    Key? key,
    required this.controller,
    this.foregroundColor = TheoColors.secondary,
  }) : super(key: key);

  final VideoPlayerController controller;

  final Color foregroundColor;

  @override
  _VideoTopBarState createState() => _VideoTopBarState();
}

class _VideoTopBarState extends State<VideoTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CloseTopBarButton(foregroundColor: widget.foregroundColor),
          AudioButton(
            controller: widget.controller,
            foregroundColor: widget.foregroundColor,
          ),
        ],
      ),
    );
  }
}
