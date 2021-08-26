import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/core/constants/story_format_consts.dart';
import 'package:theo/models/story.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/utils/assets_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LearnCardItem extends StatefulWidget {
  const LearnCardItem({
    Key? key,
    required this.number,
    required this.selected,
    required this.story,
    this.last = false,
    required this.onTap,
  }) : super(key: key);

  final String number;
  final bool selected;
  final Story story;
  final bool last;
  final Function() onTap;

  @override
  _LearnCardItemState createState() => _LearnCardItemState();
}

class _LearnCardItemState extends State<LearnCardItem> {
  AppLocalizations get _locale => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _number,
          Expanded(
            child: InkWell(
              onTap: widget.onTap,
              child: _card,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _number => Column(
        children: [
          Card(
            elevation: TheoMetrics.cardElevation,
            color: _cardNumberColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Container(
              width: 40,
              height: 40,
              child: Center(child: _numberContent),
            ),
          ),
          if (!widget.last)
            Container(
              margin: EdgeInsets.only(top: 5),
              color: TheoColors.twelve,
              height: 50,
              width: 2,
            ),
        ],
      );

  Widget get _card => Card(
        elevation: TheoMetrics.cardElevation,
        shape: RoundedRectangleBorder(
          side: _cardBorder,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 15, top: 5),
                child: _icon,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.story.format?.displayName?[_locale.localeName] ??
                          '-',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                            color: TheoColors.fourteen,
                          ),
                    ),
                    Text(
                      widget.story.title!,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                            color: TheoColors.seven,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget get _icon {
    var iconData;

    var name = widget.story.format!.name!;

    switch (name) {
      case StoryFormatConsts.VIDEO:
        iconData = FeatherIcons.video;
        break;

      case StoryFormatConsts.PODCAST:
      case StoryFormatConsts.MUSIC:
        iconData = FeatherIcons.radio;
        break;
      case StoryFormatConsts.INFROGRAPHIC:
        iconData = FeatherIcons.pieChart;
        break;
      case StoryFormatConsts.TEXT:
        iconData = FeatherIcons.fileText;
        break;
      case StoryFormatConsts.QUIZ:
        return Image(
          image: AssetImage(AssetsPath.quizPng),
        );
    }

    return Icon(
      iconData,
      color: TheoColors.ten,
      size: 30,
    );
  }

  Color get _numberColor =>
      widget.selected ? TheoColors.secondary : TheoColors.seven;

  Color get _cardNumberColor {
    if (widget.story.finished) return TheoColors.thirteen;

    return widget.selected ? TheoColors.twentySeven : TheoColors.secondary;
  }

  BorderSide get _cardBorder => widget.selected && !widget.story.finished
      ? BorderSide(width: 2, color: TheoColors.twentySeven)
      : BorderSide.none;

  Widget get _numberContent => widget.story.finished
      ? Icon(
          FeatherIcons.check,
          color: TheoColors.secondary,
        )
      : Text(
          widget.number,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: _numberColor,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
        );
}
