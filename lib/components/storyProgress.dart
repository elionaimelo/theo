import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/assetsPath.dart';

class StoryProgress extends StatelessWidget {
  StoryProgress({
    required this.progress,
    required this.total,
    this.hasThunder = true,
    this.hasTitle = true,
  });
  final int progress;
  final int total;
  final bool hasThunder;
  final bool hasTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          if (hasThunder)
            Container(
              margin: EdgeInsets.only(right: 7),
              child: _icon,
            ),
          Expanded(
            child: Column(
              children: [
                _texts,
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                ),
                _bars,
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget get _bars {
    final bars = [];

    for (var i = 0; i < total; i++) {
      bars.add(
        Expanded(
          child: Container(
            // Tip: The last item doesnt have margin
            margin: i < total - 1 ? EdgeInsets.only(right: 4) : null,
            decoration: BoxDecoration(
              color: i < progress - 1 ? TheoColors.eleven : TheoColors.twelve,
              borderRadius: BorderRadius.circular(15),
            ),
            width: 8,
            height: 8,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...bars,
      ],
    );
  }

  Widget get _texts => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            hasTitle ? 'Progresso' : '',
            style: GoogleFonts.muli(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: TheoColors.seven,
            ),
          ),
          Text(
            '0/' + total.toString(),
            style: GoogleFonts.muli(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: TheoColors.seven,
            ),
          )
        ],
      );

  Widget get _icon => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: TheoColors.ten,
        ),
        padding: EdgeInsets.all(8),
        width: 35,
        height: 35,
        child: SvgPicture.asset(
          AssetsPath.thunderSvg,
          color: TheoColors.secondary,
        ),
      );
}
