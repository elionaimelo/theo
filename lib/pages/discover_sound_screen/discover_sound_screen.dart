import 'package:flutter/material.dart';
import 'package:theo/components/adult_content_tag.dart';
import 'package:theo/components/audio_button.dart';
import 'package:theo/components/post_card_actions.dart';
import 'package:theo/components/profile_bar.dart';
import 'package:theo/components/story_app_bar.dart';
import 'package:theo/types/enums.dart';
import 'package:theo/pages/discover_sound_screen/discover_sound_screen_controller.dart';
import 'package:theo/pages/media_story_screen/components/player_inputs.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/utils/assets_path.dart';

class DiscoverSoundScreen extends StatefulWidget {
  const DiscoverSoundScreen({Key? key, required this.controller})
      : super(key: key);

  @override
  _DiscoverSoundScreenState createState() => _DiscoverSoundScreenState();

  final DiscoverSoundScreenController controller;
}

class _DiscoverSoundScreenState extends State<DiscoverSoundScreen> {
  @override
  void initState() {
    super.initState();

    widget.controller.videoController.initialize();
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
            name: widget.controller.story.user?.profile?.name ?? '',
          ),
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 12),
            child: _author,
          ),
          if (widget.controller.story.adultContent) AdultContentTag(),
          Container(
            margin: EdgeInsets.only(top: 45),
          ),
          Expanded(
            child: Container(
              child: Image(
                image: AssetImage(
                  _isPodcast ? AssetsPath.podcastPng : AssetsPath.discoverMusic,
                ),
              ),
            ),
          ),
          _audioTitle,
          PlayerInputs(
            videoController: widget.controller.videoController,
            foregroundColor: TheoColors.primary,
            playButtonColor: TheoColors.primary,
            textColor: TheoColors.seven,
            maximizeButton: false,
          ),
          PostCardActions(likesCount: 16, commentsCount: 4),
        ],
      ),
    );
  }

  Widget get _audioTitle => Container(
        child: Text(
          widget.controller.story.title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                color: TheoColors.six,
                fontWeight: FontWeight.w700,
              ),
        ),
      );

  Widget get _author => Text(
        widget.controller.story.author,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 14,
              color: TheoColors.seven,
            ),
      );

  bool get _isPodcast => widget.controller.story.format == EStoryFormat.PODCAST;
}
