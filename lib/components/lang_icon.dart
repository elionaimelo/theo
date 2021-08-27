import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theo/utils/assets_path.dart';

class LangIcon extends StatelessWidget {
  const LangIcon({
    Key? key,
    required this.languageCode,
  }) : super(key: key);

  final String? languageCode;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: _icon,
    );
  }

  Widget get _icon => languageCode != null
      ? SvgPicture.asset(
          AssetsPath.getLangIconSvg(languageCode!),
          height: 28,
        )
      : Icon(
          Icons.error,
          size: 28,
        );
}
