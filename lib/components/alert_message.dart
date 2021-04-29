import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/styles/colors.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: TheoColors.seventeen, width: 0),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        color: TheoColors.seventeen,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FeatherIcons.alertCircle,
                color: TheoColors.primary,
              ),
              Container(
                margin: EdgeInsets.only(left: 7),
                child: Text(
                  'Lembrete',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: TheoColors.primary,
                      ),
                ),
              ),
            ],
          ),
          Text(
            text,
            maxLines: 3,
          )
        ],
      ),
    );
  }
}
