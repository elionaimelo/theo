import 'package:flutter/material.dart';
import 'package:theo/styles/colors.dart';

class SubTitleText extends StatelessWidget {
  const SubTitleText({
    Key? key,
    this.subTitle,
  }) : super(key: key);

  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle!,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: TheoColors.six, fontWeight: FontWeight.normal, fontSize: 15),
    );
  }
}
