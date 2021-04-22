import 'package:flutter/material.dart';
import 'package:theo/styles/colors.dart';

class TitleButton extends StatelessWidget {
  const TitleButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: TheoColors.six, fontWeight: FontWeight.w900, fontSize: 18),
    );
  }
}
