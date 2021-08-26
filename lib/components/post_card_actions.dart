import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/assets_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostCardActions extends StatefulWidget {
  const PostCardActions({
    Key? key,
    required this.likesCount,
    required this.commentsCount,
    this.horizontalPadding = 0,
  }) : super(key: key);

  @override
  _PostCardActionsState createState() => _PostCardActionsState();

  final int? likesCount;
  final int? commentsCount;
  final double horizontalPadding;
}

class _PostCardActionsState extends State<PostCardActions> {
  _PostCardActionsState();

  AppLocalizations get _locale => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    _likesCount = widget.likesCount;
  }

  int? _likesCount = 0;
  bool _likeSelected = false;

  void _likeButtonTap() {
    setState(() {
      _likeSelected = !_likeSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _likeCommentsCount,
          _divider,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _actionButton(
                icon: FeatherIcons.thumbsUp,
                text: _locale.postLike,
                onTap: _likeButtonTap,
                selected: _likeSelected,
              ),
              _actionButton(
                icon: FeatherIcons.messageCircle,
                text: _locale.postComment,
                onTap: () {},
              ),
              _actionButton(
                icon: FeatherIcons.cornerUpRight,
                text: _locale.postShare,
                onTap: () {},
              ),
              _actionButton(
                icon: FeatherIcons.download,
                text: _locale.postDownload,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _divider => Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
        child: Divider(
          height: 1,
          thickness: 1,
          color: TheoColors.twentyFour,
        ),
      );

  Widget get _likeCommentsCount {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetsPath.thumbsUpSvg),
          _likeText,
          Expanded(child: Container()),
          Text(
            (widget.commentsCount?.toString() ?? '0') + ' ' + _locale.comments,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: TheoColors.seven,
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }

  Widget get _likeText {
    if (widget.likesCount != null) {
      return Text(
        _likeSelected ? (_likesCount! + 1).toString() : _likesCount.toString(),
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: TheoColors.seven,
              fontSize: 14,
            ),
      );
    }

    return Container();
  }

  Widget _actionButton({
    required IconData icon,
    required String text,
    required Function() onTap,
    bool selected = false,
  }) =>
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            children: [
              Icon(
                icon,
                color: selected ? TheoColors.eleven : TheoColors.twentyFive,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 12,
                      color:
                          selected ? TheoColors.eleven : TheoColors.twentyFive,
                    ),
              )
            ],
          ),
        ),
      );
}
