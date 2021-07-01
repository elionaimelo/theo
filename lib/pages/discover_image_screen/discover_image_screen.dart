import 'package:flutter/material.dart';
import 'package:theo/components/adult_content_tag.dart';
import 'package:theo/components/post_card_actions.dart';
import 'package:theo/components/profile_bar.dart';
import 'package:theo/components/story_app_bar.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/utils/assets_path.dart';

class DiscoverImageScreen extends StatefulWidget {
  const DiscoverImageScreen({Key? key}) : super(key: key);

  @override
  _DiscoverImageScreenState createState() => _DiscoverImageScreenState();
}

class _DiscoverImageScreenState extends State<DiscoverImageScreen> {
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
            name: 'Nome do usuário',
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
            child: FadeInImage.assetNetwork(
              placeholder: AssetsPath.spinnerGif,
              image:
                  'https://www.lookandlearn.com/history-images/preview/XR/XR442/XR442726_Punch-cartoon-Victorian-womens-fashion-the-wide-hoop-skirt.jpg',
            ),
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
