import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class AdultContentTag extends StatelessWidget {
  const AdultContentTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            FeatherIcons.eyeOff,
          ),
          Container(
            margin: EdgeInsets.only(right: 8),
          ),
          Text(
            'Conteúdo para maiores de 18',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
