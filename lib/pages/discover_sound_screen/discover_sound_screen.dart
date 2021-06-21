import 'package:flutter/material.dart';
import 'package:theo/components/post_card_actions.dart';
import 'package:theo/components/profile_bar.dart';
import 'package:theo/components/story_app_bar.dart';
import 'package:theo/pages/video_story_screen/components/player_inputs.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/utils/assets_path.dart';

class DiscoverSoundScreen extends StatefulWidget {
  const DiscoverSoundScreen({Key? key}) : super(key: key);

  @override
  _DiscoverSoundScreenState createState() => _DiscoverSoundScreenState();
}

class _DiscoverSoundScreenState extends State<DiscoverSoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TheoMetrics.paddingScreenWithTopMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StoryAppBar(),
          Container(
            margin: EdgeInsets.only(top: 45),
          ),
          ProfileBar(
            avatarImage: AssetsPath.avatarJpg,
            name: 'Astrogilda Nunes',
          ),
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 12),
            child: _author,
          ),
          Container(
            margin: EdgeInsets.only(top: 45),
          ),
          Expanded(
            child: Container(
              child: Image(
                image: AssetImage(AssetsPath.podcastPng),
              ),
            ),
          ),
          PlayerInputs(
            videoController: _videoController,
            foregroundColor: _foregroundColor,
            playButtonColor: _playButtonColor,
            textColor: _textColor,
            maximizeButton: _isVideoFormat,
          ),
          PostCardActions(likesCount: 16, commentsCount: 4),
        ],
      ),
    );
  }

  Widget get _author => Text(
        'Autoria: Tarcila Cabral',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 14,
              color: TheoColors.seven,
            ),
      );
}
