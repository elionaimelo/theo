import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:theo/components/theo_bottom_bar.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/pages/home_screen/home_screen.dart';
import 'package:theo/pages/home_screen/home_screen_controller.dart';
import 'package:theo/pages/login_screen/login_screen.dart';
import 'package:theo/pages/splash_screen/splash_screen.dart';

class TheoNavigator extends StatefulWidget {
  @override
  _TheoNavigatorState createState() => _TheoNavigatorState();

  final _navigatorKey = GlobalKey<NavigatorState>();
}

class _TheoNavigatorState extends State<TheoNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget._navigatorKey,
      initialRoute: Routes.splash,
      onGenerateRoute: (RouteSettings settings) {
        Widget screen;
        // Manage your route names here
        switch (settings.name) {
          case Routes.splash:
            screen = SplashScreen();
            break;

          case Routes.login:
            screen = LoginScreen();
            break;

          case Routes.home:
            screen = _homeScreen;
            break;

          default:
            throw Exception('Invalid route: ${settings.name}');
        }

        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: screen,
            bottomNavigationBar: TheoBottomBar(
              navigationStore: GetIt.I.get(),
              visible: hasBottomBar(settings.name ?? Routes.splash),
            ),
          ),
          settings: settings,
        );
      },
    );
  }

  Widget get _homeScreen => HomeScreen(
        controller: HomeScreenController(
          navigationStore: GetIt.I.get(),
        ),
      );

  bool hasBottomBar(String route) {
    if (route != Routes.splash &&
        route != Routes.start &&
        route != Routes.login) {
      return true;
    }

    return false;
  }
}
