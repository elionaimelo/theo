import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/assets_path.dart';

class PostCardActions extends StatefulWidget {
  const PostCardActions({
    Key? key,
    required this.likesCount,
    required this.commentsCount,
    this.horizontalPadding = 0,
  }) : super(key: key);

  @override
  _PostCardActionsState createState() => _PostCardActionsState();

  final int likesCount;
  final int commentsCount;
  final double horizontalPadding;
}

class _PostCardActionsState extends State<PostCardActions> {
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
                onTap: () {},
              ),
              _actionButton(
                icon: FeatherIcons.messageCircle,
                text: 'Comentar',
                onTap: () {},
              ),
              _actionButton(
                icon: FeatherIcons.cornerUpRight,
                text: 'Compartilhar',
                onTap: () {},
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
            widget.likesCount.toString(),
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
    required Function onTap,
  }) =>
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            children: [
              Icon(
                icon,
                color: TheoColors.twentyFive,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 12,
                      color: TheoColors.twentyFive,
                    ),
              )
            ],
          ),
        ),
      );
}
