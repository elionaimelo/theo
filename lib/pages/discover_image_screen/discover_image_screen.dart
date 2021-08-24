import 'package:flutter/material.dart';
import 'package:theo/components/adult_content_tag.dart';
import 'package:theo/components/lazy_image.dart';
import 'package:theo/components/post_card_actions.dart';
import 'package:theo/components/profile_bar.dart';
import 'package:theo/components/story_app_bar.dart';
import 'package:theo/pages/discover_image_screen/discover_image_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/utils/assets_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiscoverImageScreen extends StatefulWidget {
  const DiscoverImageScreen({Key? key, required this.controller})
      : super(key: key);

  @override
  _DiscoverImageScreenState createState() => _DiscoverImageScreenState();
  final DiscoverImageScreenController controller;
}

class _DiscoverImageScreenState extends State<DiscoverImageScreen> {
  AppLocalizations get _locale => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TheoColors.secondary,
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
            name: widget.controller.post.user?.profile?.name ?? '-',
          ),
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 12),
            child: _author,
          ),
          AdultContentTag(),
          Container(
            margin: EdgeInsets.only(top: 45),
          ),
          Expanded(
              child: Center(
            child: LazyImage(
              file: widget.controller.post.thumbnailImage,
            ),
          )),
          PostCardActions(
              likesCount: widget.controller.post.likesCount,
              commentsCount: widget.controller.post.commentsCount),
        ],
      ),
    );
  }

  Widget get _author => Text(
        _locale.authorship +
            ': ' +
            (widget.controller.post.story?.author ?? '-'),
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 14,
              color: TheoColors.seven,
            ),
      );
}
