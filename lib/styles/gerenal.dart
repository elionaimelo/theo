import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'colors.dart';

class TheoStyles {
  late BuildContext _buildContext;

  static TheoStyles of(BuildContext context) {
    var instance = TheoStyles();

    instance._buildContext = context;

    return instance;
  }

  TextStyle get labelInputStyle =>
      Theme.of(_buildContext).textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: TheoColors.seven,
          );
}
