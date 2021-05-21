import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/text_icon_button.dart';
import 'package:theo/styles/colors.dart';
import 'package:video_player/video_player.dart';

class VideoTopBar extends StatefulWidget {
  VideoTopBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VideoPlayerController controller;

  @override
  _VideoTopBarState createState() => _VideoTopBarState();
}

class _VideoTopBarState extends State<VideoTopBar> {
  bool isMuted = false;

  void _volumeButton() {
    setState(() {
      isMuted = !isMuted;
    });
    widget.controller.setVolume(isMuted ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextIconButton(
            onTap: () => Navigator.of(context).pop(),
            foregroundColor: TheoColors.secondary,
            icon: Icon(
              FeatherIcons.x,
              color: TheoColors.secondary,
              size: 30,
            ),
          ),
          IconButton(
            icon: Icon(
              isMuted ? FeatherIcons.volumeX : FeatherIcons.volume2,
              color: TheoColors.secondary,
              size: 30,
            ),
            onPressed: _volumeButton,
          ),
        ],
      ),
    );
  }
}
