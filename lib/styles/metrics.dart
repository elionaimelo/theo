import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TheoMetrics {
  static double appBarHeight = 46;
  static EdgeInsets paddingScreen =
      EdgeInsets.symmetric(horizontal: 16, vertical: 31);
  static double cardElevation = 5;

  static EdgeInsets paddingScreenWithTopMargin =
      paddingScreen.copyWith(top: AppBar().preferredSize.height);
}
