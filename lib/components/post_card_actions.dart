import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/assets_path.dart';
import 'package:flutter/services.dart';

class PostCardActions extends StatefulWidget {
  const PostCardActions({
    Key? key,
    required this.likesCount,
    required this.commentsCount,
    this.horizontalPadding = 0,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  _PostCardActionsState createState() => _PostCardActionsState();

  final int likesCount;
  final int commentsCount;
  final double horizontalPadding;
  final String image;
  final String title;
}

class _PostCardActionsState extends State<PostCardActions> {
  @override
  void initState() {
    super.initState();
    _likesCount = widget.likesCount;
  }

  int _likesCount = 0;
  bool _likeSelected = false;

  void _likeButtonTap() {
    setState(() {
      _likeSelected = !_likeSelected;
    });
  }

  Future<void> _shareButtonTap() async {
    await Share.share('dsfsfsd', subject: 'sdfisdjf');
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
                text: 'Gostei',
                onTap: _likeButtonTap,
                selected: _likeSelected,
              ),
              _actionButton(
                icon: FeatherIcons.messageCircle,
                text: 'Comentar',
                onTap: () {},
              ),
              _actionButton(
                icon: FeatherIcons.cornerUpRight,
                text: 'Compartilhar',
                onTap: _shareButtonTap,
              ),
              _actionButton(
                icon: FeatherIcons.download,
                text: 'Baixar',
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
    var textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          color: TheoColors.seven,
          fontSize: 14,
        );

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetsPath.thumbsUpSvg),
          Text(
            _likeSelected
                ? (_likesCount + 1).toString()
                : _likesCount.toString(),
            style: textStyle,
          ),
          Expanded(child: Container()),
          Text(
            widget.commentsCount.toString() + ' comentários',
            style: textStyle,
          ),
        ],
      ),
    );
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
