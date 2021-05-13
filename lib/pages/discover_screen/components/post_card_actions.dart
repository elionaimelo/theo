import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/styles/colors.dart';

class PostCardActions extends StatefulWidget {
  @override
  _PostCardActionsState createState() => _PostCardActionsState();
}

class _PostCardActionsState extends State<PostCardActions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
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
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String text,
    required Function onTap,
  }) =>
      Expanded(
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: TheoColors.twentyFive,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14,
                        color: TheoColors.twentyFive,
                      ),
                )
              ],
            ),
          ),
        ),
      );
}
