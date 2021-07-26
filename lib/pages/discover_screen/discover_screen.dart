import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/components/result_status/loading_status.dart';
import 'package:theo/components/title_text.dart';
import 'package:theo/core/constants/story_format_consts.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/models/post.dart';
import 'package:theo/pages/discover_screen/components/post_card.dart';
import 'package:theo/pages/discover_screen/discover_screen_controller.dart';
import 'package:theo/pages/discover_sound_screen/discover_media_screen.dart';
import 'package:theo/pages/discover_sound_screen/discover_media_screen_controller.dart';
import 'package:theo/pages/media_story_screen/media_story_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/types/enums.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();

  final DiscoverScreenController controller;
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  void _onSearchTap() {
    Navigator.of(context).pushNamed(Routes.search);
  }

  @override
  void initState() {
    super.initState();

    widget.controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (widget.controller.eResultStatus == EResultStatus.LOADING) {
          return LoadingStatus();
        } else if (widget.controller.eResultStatus ==
            EResultStatus.REQUEST_ERROR) {
          return ErrorAlertDialog(
            content: widget.controller.errorMessage,
            withButton: false,
          );
        }

        return _content;
      },
    );
  }

  Widget get _content => Container(
        child: ListView(
          children: [
            Padding(
              padding: TheoMetrics.paddingScreen.copyWith(bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BottomButton(
                    text: 'Pesquisar',
                    borderColor: TheoColors.primary,
                    backgroundColor: TheoColors.secondary,
                    primaryColor: TheoColors.primary,
                    icon: FeatherIcons.filter,
                    textDirection: TextDirection.rtl,
                    onPressed: _onSearchTap,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 28),
                    child: TitleText(
                      title: 'Descobrir histórias',
                    ),
                  ),
                ],
              ),
            ),
            ...widget.controller.posts.map(
              (e) => PostCard(
                post: e,
                onTapMore: () => _onTapCard(e),
              ),
            ),
          ],
        ),
      );

  void _onTapCard(Post p) {
    if (p.story == null || p.story?.format == null) return;

    var format = p.story!.format;

    switch (format!.name) {
      case StoryFormatConsts.VIDEO:
        Navigator.of(context).pushNamed(
          Routes.discoverMedia,
          arguments: DiscoverMediaScreenController(post: p),
        );
        break;
      default:
    }
  }
}
