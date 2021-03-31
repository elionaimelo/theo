import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:theo/pages/login_screen/login_screen.dart';
import 'package:theo/pages/splash_screen/splash_screen.dart';

import 'package:theo/core/routes.dart';

import 'package:theo/constant.dart';

void main() {
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
        primaryColor: kprimaryColor,
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: {
        Routes.splash: (context) => SplashScreen(),
        Routes.login: (context) => LoginScreen()
      },
    );
  }
}
