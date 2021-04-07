import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/styles/colors.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class StoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 17),
        child: Column(
          children: [
            _title,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _status,
                _button,
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget get _status => Container();

  Widget get _title => Text(
        'Primeiro titulo aqui - Sobre o storytelling?',
        style: GoogleFonts.muli(
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      );

  Widget get _button => Ink(
        decoration: BoxDecoration(
          border: Border.all(
            color: TheoColors.primary,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(FeatherIcons.plus),
                Container(
                  margin: EdgeInsets.only(left: 5),
                ),
                Text('Iniciar'),
              ],
            ),
          ),
        ),
      );
}
