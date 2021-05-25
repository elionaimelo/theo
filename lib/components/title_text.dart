import 'package:flutter/material.dart';
import 'package:theo/styles/colors.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      style: Theme.of(context).textTheme.headline2!.copyWith(
          color: TheoColors.primary, fontWeight: FontWeight.w900, fontSize: 20),
    );
  }
}
