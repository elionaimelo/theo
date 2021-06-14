import 'package:flutter/material.dart';

import 'package:theo/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                TheoColors.third,
                TheoColors.forth,
              ],
            ),
            image: DecorationImage(
              image: AssetImage('assets/images/logo-theo-branco.png'),
              fit: BoxFit.none,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 90),
              child: Text(
                'Carregando...',
                style: GoogleFonts.muli().copyWith(
                  fontSize: 18,
                  color: TheoColors.secondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
