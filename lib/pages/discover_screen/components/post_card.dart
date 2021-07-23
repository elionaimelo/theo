import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theo/components/lazy_image.dart';
import 'package:theo/components/profile_bar.dart';
import 'package:theo/components/text_icon_button.dart';
import 'package:theo/components/post_card_actions.dart';
import 'package:theo/core/constants/story_format_consts.dart';
import 'package:theo/models/post.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/assets_path.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    Key? key,
    required this.post,
    this.onTapMore,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();

  final Function()? onTapMore;
  final Post post;
}

class _PostCardState extends State<PostCard> {
  final double _horizontalPadding = 18;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          _profile,
          _textBody,
          _cardImage,
          _cardBody,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: PostCardActions(
              likesCount: widget.post.likes.length,
              commentsCount: widget.post.comments.length,
              horizontalPadding: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _profile => Container(
        padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        margin: EdgeInsets.only(bottom: 11),
        child: Row(
          children: [
            ProfileBar(
              avatarSize: 30,
              avatarImage: AssetsPath.avatarJpg,
              name: widget.post.user?.profile?.name ?? '-',
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: TextIconButton(
                  onTap: () => widget.onTapMore?.call(),
                  icon: Icon(
                    FeatherIcons.plus,
                    color: TheoColors.primary,
                    size: 20,
                  ),
                  direction: TextDirection.rtl,
                  text: 'Saiba mais',
                  textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14,
                        color: TheoColors.primary,
                      ),
                ),
              ),
            )
          ],
        ),
      );

  Widget get _textBody => widget.post.story?.description != null
      ? Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
              bottom: 7, left: _horizontalPadding, right: _horizontalPadding),
          child: Text(
            widget.post.story?.description ?? '-',
          ),
        )
      : Container();

  Widget get _cardImage {
    Widget image = SvgPicture.asset(
      AssetsPath.defaultCardSvg,
      fit: BoxFit.cover,
    );

    if (widget.post.thumbnailImage != null) {
      image = LazyImage(file: widget.post.thumbnailImage!);
    }

    return Container(
      color: Colors.red,
      child: Stack(
        children: [
          image,
          if (_hasCenterPlayer)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Icon(
                FeatherIcons.playCircle,
                color: TheoColors.secondary,
                size: 35,
              ),
            ),
          if (widget.post.story?.adultContent ?? false)
            Positioned(
              bottom: 0,
              right: 0,
              child: _adultTag,
            )
        ],
      ),
    );
  }

  Widget get _cardBody => Container(
        color: TheoColors.fiftteen,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 17),
        child: Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _typeDescription,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: TheoColors.twenty,
                          fontSize: 14,
                        ),
                  ),
                  Text(
                    widget.post.story?.title ?? '-',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: TheoColors.seven,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text('Autoria: ' + (widget.post.story?.author ?? '-')),
                ],
              ),
            ),
            if (_hasRightPlayer)
              Container(
                margin: EdgeInsets.only(left: 30, right: 13),
                child: Icon(
                  FeatherIcons.playCircle,
                  color: TheoColors.sixteen,
                  size: 35,
                ),
              )
          ],
        ),
      );

  Widget get _adultTag => Container(
        margin: EdgeInsets.only(right: 18, bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: TheoColors.seven,
        ),
        child: Row(
          children: [
            Text(
              '-18',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 15, color: TheoColors.secondary),
            ),
            Container(
              margin: EdgeInsets.only(right: 15),
            ),
            Icon(
              FeatherIcons.eyeOff,
              color: TheoColors.secondary,
            )
          ],
        ),
      );

  String get _typeDescription =>
      (widget.post.story?.category?.name ?? '-') +
      ' | ' +
      (widget.post.story?.format?.displayName ?? '-');

  bool get _hasRightPlayer {
    switch (widget.post.story?.format?.name) {
      case StoryFormatConsts.PODCAST:
      case StoryFormatConsts.MUSIC:
        return true;
      default:
        return false;
    }
  }

  bool get _hasCenterPlayer {
    switch (widget.post.story?.format?.name) {
      case StoryFormatConsts.VIDEO:
        return true;
      default:
        return false;
    }
  }
}
