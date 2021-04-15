import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/pages/learning_screen/learningScreen.dart';

import 'package:theo/core/routes.dart';
import 'package:theo/styles/colors.dart';

import 'package:theo/pages/splash_screen/splash_screen.dart';
import 'package:theo/pages/start_screen/start_screen.dart';
import 'package:theo/pages/login_screen/login_screen.dart';
import 'package:theo/pages/home_screen/home_screen.dart';

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
        primaryColor: TheoColors.primary,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: {
        Routes.splash: (context) => SplashScreen(),
        Routes.start: (context) => StartScreen(),
        Routes.login: (context) => LoginScreen(),
        Routes.learning: (context) => LearningScreen(),
        Routes.home: (context) => HomeScreen()
      },
    );
  }
}
