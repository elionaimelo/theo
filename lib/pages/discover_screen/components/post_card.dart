import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theo/components/profile_bar.dart';
import 'package:theo/components/text_icon_button.dart';
import 'package:theo/components/post_card_actions.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/assets_path.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    Key? key,
    required this.avatarImage,
    required this.profileName,
    this.textBody,
    required this.likesCount,
    required this.commentsCount,
    required this.title,
    required this.type,
    this.format,
    required this.author,
    this.adultRestriction = false,
    required this.cardImage,
    this.onTapMore,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();

  final String avatarImage;
  final String profileName;
  final String? textBody;
  final int likesCount;
  final int commentsCount;
  final String title;
  final String type;
  final String? format;
  final String author;
  final bool adultRestriction;
  final String cardImage;
  final Function()? onTapMore;
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
          PostCardActions(
            likesCount: widget.likesCount,
            commentsCount: widget.commentsCount,
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
              avatarImage: widget.avatarImage,
              name: widget.profileName,
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

  Widget get _textBody => widget.textBody != null
      ? Container(
          margin: EdgeInsets.only(
              bottom: 7, left: _horizontalPadding, right: _horizontalPadding),
          child: Text(
            widget.textBody!,
          ),
        )
      : Container();

  Widget get _cardImage => Container(
        color: Colors.red,
        child: Stack(
          children: [
            SvgPicture.asset(
              widget.cardImage,
              fit: BoxFit.cover,
            ),
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
            if (widget.adultRestriction)
              Positioned(
                bottom: 0,
                right: 0,
                child: _adultTag,
              )
          ],
        ),
      );

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
                    _text,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: TheoColors.twenty,
                          fontSize: 14,
                        ),
                  ),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: TheoColors.seven,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text('Autoria: ' + widget.author),
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

  String get _text => widget.format != null
      ? widget.type + ' | ' + widget.format!
      : widget.type;

  bool get _hasRightPlayer {
    switch (widget.format) {
      case 'Podcast':
        return true;
      case 'Música':
        return true;
      default:
        return false;
    }
  }

  bool get _hasCenterPlayer {
    switch (widget.format) {
      case 'Vídeo':
        return true;
      default:
        return false;
    }
  }
}
