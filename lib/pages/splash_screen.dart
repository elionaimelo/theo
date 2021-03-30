import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart' as flutterSplash;
import 'package:theo/core/routes.dart';
import 'package:theo/pages/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Widget> isAuthenticate() async {
    return Future.delayed(Duration(seconds: 3), () => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return flutterSplash.SplashScreen(
      navigateAfterFuture: isAuthenticate(),
      title: Text('Welcome In SplashScreen'),
      backgroundColor: Colors.green,
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
      routeName: Routes.login,
    );
  }
}
