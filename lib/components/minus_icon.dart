import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/styles/colors.dart';

class MinusIcon extends StatelessWidget {
  const MinusIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      padding: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: TheoColors.thirtyOne,
        shape: BoxShape.circle,
      ),
      child: Icon(
        FeatherIcons.minus,
        color: Colors.white,
      ),
    );
  }
}
