import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/assets_path.dart';

class NotFoundStatus extends StatelessWidget {
  const NotFoundStatus({Key? key, this.title, this.description})
      : super(key: key);

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _title(context),
          Image(
            image: AssetImage(AssetsPath.notfound),
          ),
          _description(context),
        ],
      ),
    );
  }

  Widget _title(BuildContext context) => title != null
      ? Container(
          margin: EdgeInsets.only(bottom: 25),
          child: Text(
            title!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: TheoColors.primary,
                ),
          ),
        )
      : Container();

  Widget _description(BuildContext context) => description != null
      ? Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            title!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: TheoColors.six,
                ),
          ),
        )
      : Container();
}
