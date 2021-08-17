import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/components/result_status/loading_status.dart';
import 'package:theo/components/subTitleText.dart';
import 'package:theo/components/title_text.dart';
import 'package:theo/core/constants/story_format_consts.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/models/story_format.dart';
import 'package:theo/pages/new_tell_screen/new_tell_screen_controller.dart';
import 'package:theo/pages/tell_screen/components/tell_menu_item.dart';
import 'package:theo/pages/tell_screen/tell_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/types/enums.dart';
import 'package:theo/utils/assets_path.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TellScreen extends StatefulWidget {
  const TellScreen({Key? key, required this.controller}) : super(key: key);

  final TellScreenController controller;

  @override
  _TellScreenState createState() => _TellScreenState();
}

class _TellScreenState extends State<TellScreen>
    with AutomaticKeepAliveClientMixin<TellScreen> {
  AppLocalizations get _locale => AppLocalizations.of(context)!;

  @override
  bool get wantKeepAlive => true;

  void _onMenuItemTap({
    required StoryFormat format,
    bool withLink = false,
    bool withArchive = false,
  }) {
    Navigator.pushNamed(
      context,
      Routes.newTell,
      arguments: NewTellScreenController(
        format: format,
        withLink: withLink,
        withArchive: withArchive,
        navigationStore: GetIt.I.get(),
        languageStore: GetIt.I.get(),
        storyCategoryStore: GetIt.I.get(),
        authStore: GetIt.I.get(),
        postStore: GetIt.I.get(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    widget.controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Observer(builder: (_) {
      if (widget.controller.eResultStatus == EResultStatus.LOADING) {
        return LoadingStatus();
      } else if (widget.controller.eResultStatus ==
          EResultStatus.REQUEST_ERROR) {
        return ErrorAlertDialog(content: widget.controller.errorMessage);
      }

      return _content;
    });
  }

  Widget get _content => Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title,
                  SubTitleText(
                    subTitle: _locale.tellSubtitle,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
            ),
            Expanded(child: _list),
          ],
        ),
      );

  Widget get _list => ListView.builder(
        itemBuilder: (_, int i) => _itemBuilder(i),
        itemCount: widget.controller.storyFormats.length,
      );

  Widget _itemBuilder(int index) {
    var menuItem = getMenuItem(widget.controller.storyFormats[index]);

    if (menuItem == null) return Container();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(
            height: 1,
            thickness: 1,
          ),
        ),
        menuItem,
      ],
    );
  }

  Widget get _title => TitleText(
        title: _locale.tellTitle,
      );

  Widget? getMenuItem(StoryFormat storyFormat) {
    switch (storyFormat.name) {
      case StoryFormatConsts.VIDEO:
        return Container(
          margin: EdgeInsets.only(top: 5),
          child: TellMenuItem(
            icon: Icon(
              FeatherIcons.video,
              color: TheoColors.eleven,
            ),
            text: storyFormat.displayName,
            onTap: () => _onMenuItemTap(format: storyFormat),
          ),
        );

      case StoryFormatConsts.ANIMATION:
        return TellMenuItem(
          icon: SvgPicture.asset(AssetsPath.animationSvg),
          text: storyFormat.displayName,
          onTap: () => _onMenuItemTap(format: storyFormat, withLink: true),
        );

      case StoryFormatConsts.TEXT:
        return TellMenuItem(
          icon: Icon(
            FeatherIcons.fileText,
            color: TheoColors.primary,
          ),
          text: storyFormat.displayName,
          onTap: () => _onMenuItemTap(format: storyFormat, withArchive: true),
        );

      case StoryFormatConsts.HQ:
        return TellMenuItem(
          icon: SvgPicture.asset(AssetsPath.comicSvg),
          text: storyFormat.displayName,
          onTap: () => _onMenuItemTap(format: storyFormat),
        );

      case StoryFormatConsts.GAME:
        return TellMenuItem(
          icon: SvgPicture.asset(AssetsPath.gameSvg),
          text: storyFormat.displayName,
          onTap: () => _onMenuItemTap(format: storyFormat, withLink: true),
        );

      case StoryFormatConsts.INFROGRAPHIC:
        return TellMenuItem(
          icon: Icon(
            FeatherIcons.pieChart,
            color: TheoColors.primary,
          ),
          text: storyFormat.displayName,
          onTap: () => _onMenuItemTap(format: storyFormat, withArchive: true),
        );
      case StoryFormatConsts.IMAGE:
        return TellMenuItem(
          icon: Icon(
            FeatherIcons.image,
            color: TheoColors.eleven,
          ),
          text: storyFormat.displayName,
          onTap: () => _onMenuItemTap(format: storyFormat),
        );
      case StoryFormatConsts.INTERACTIVE_FIGURE:
        return TellMenuItem(
          icon: SvgPicture.asset(AssetsPath.interactiveSvg),
          text: storyFormat.displayName,
          onTap: () => _onMenuItemTap(format: storyFormat),
        );
      case StoryFormatConsts.MUSIC:
        return TellMenuItem(
          icon: Icon(
            FeatherIcons.music,
            color: TheoColors.primary,
          ),
          text: storyFormat.displayName,
          onTap: () => _onMenuItemTap(format: storyFormat, withArchive: true),
        );
      case StoryFormatConsts.PODCAST:
        return TellMenuItem(
          icon: Icon(
            FeatherIcons.radio,
            color: TheoColors.eleven,
          ),
          text: storyFormat.displayName,
          onTap: () => _onMenuItemTap(format: storyFormat, withLink: true),
        );
    }
  }
}
