import 'package:flutter/material.dart';
import 'package:theo/styles/colors.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    Key key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline2.copyWith(
                color: TheoColors.primary,
                fontWeight: FontWeight.w900,
                fontSize: 20),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: Theme.of(context).textTheme.headline2.copyWith(
                  color: TheoColors.seven,
                  fontWeight: FontWeight.normal,
                  fontSize: 15),
            ),
        ],
      ),
    );
  }
}
