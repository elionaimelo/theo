import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/styles/colors.dart';

class TellMenuItem extends StatelessWidget {
  TellMenuItem({this.icon, this.text, this.onTap});

  final Widget icon;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            icon,
            Container(
              margin: EdgeInsets.only(right: 13),
            ),
            _text(context),
            Expanded(
              child: Container(),
            ),
            _arrowIcon,
          ],
        ),
      ),
    );
  }

  Widget _text(BuildContext context) => Text(
        text ?? '',
        style: Theme.of(context).textTheme.headline1.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: TheoColors.seven,
            ),
      );

  Widget get _arrowIcon => Icon(
        FeatherIcons.chevronRight,
        color: TheoColors.seven,
      );
}
