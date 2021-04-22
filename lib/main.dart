import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:theo/components/theo_bottom_bar.dart';
import 'package:theo/core/navigator.dart';
import 'package:theo/core/services_locator.dart';
import 'package:theo/styles/colors.dart';

void main() {
  ServicesLocator().setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: TheoColors.primary,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        body: TheoNavigator(
          navigationStore: GetIt.I.get(),
        ),
        bottomNavigationBar: TheoBottomBar(
          navigationStore: GetIt.I.get(),
        ),
      ),
    );
  }
}
