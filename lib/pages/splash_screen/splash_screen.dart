import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart' as flutter_splash;
import 'package:theo/core/routes.dart';
import 'package:theo/pages/login_screen.dart';
import 'package:theo/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Widget> isAuthenticated() async {
    return Future.delayed(Duration(seconds: 3), () => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        flutter_splash.SplashScreen(
          navigateAfterFuture: isAuthenticated(),
          gradientBackground: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              TheoColors.third,
              TheoColors.forth,
            ],
          ),
          photoSize: 100.0,
          useLoader: false,
          routeName: Routes.login,
          loadingText: Text(
            'Carregando...',
            style: GoogleFonts.muli(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logo-theo-branco.png'),
              fit: BoxFit.none,
            ),
          ),
        ),
      ],
    );
  }
}
