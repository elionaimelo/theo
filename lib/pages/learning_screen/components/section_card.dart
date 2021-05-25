import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/models/section.dart';
import 'package:theo/states/story_store.dart';
import 'package:theo/styles/colors.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class SectionCard extends StatelessWidget {
  SectionCard({
    required this.section,
    required this.onStartTap,
  });

  final Section section;
  final Function() onStartTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title,
            Container(
              margin: EdgeInsets.only(bottom: 20),
            ),
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

  Widget get _checkedIcon => Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: TheoColors.thirteen,
        ),
        child: Icon(
          FeatherIcons.check,
          color: TheoColors.secondary,
        ),
      );

  Widget get _status {
    // normally the API would provide the finished virtual property, but in this case
    // because its only app layout development so I create this function

    var finished = GetIt.I.get<StoryStore>().isSectionFinished(section.id);

    return finished
        ? Container(
            child: Row(
              children: [
                _checkedIcon,
                Container(
                  margin: EdgeInsets.only(left: 7),
                ),
                Text(
                  'Concluído',
                  style: GoogleFonts.muli(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: TheoColors.thirteen,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget get _title => Text(
        section.title,
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
          onTap: onStartTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FeatherIcons.plus,
                  color: TheoColors.primary,
                ),
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
