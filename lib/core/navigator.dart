import 'package:flutter/material.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/pages/home_screen/home_screen.dart';
import 'package:theo/pages/home_screen/home_screen_controller.dart';
import 'package:theo/pages/login_screen/login_screen.dart';
import 'package:theo/pages/splash_screen/splash_screen.dart';
import 'package:theo/pages/start_screen/start_screen.dart';
import 'package:theo/pages/tell_screen/tell_screen.dart';
import 'package:theo/states/navigation_store.dart';

class TheoNavigator extends StatefulWidget {
  TheoNavigator({required this.navigationStore});
  @override
  _TheoNavigatorState createState() => _TheoNavigatorState();

  final NavigationStore navigationStore;
}

class _TheoNavigatorState extends State<TheoNavigator> {
  Future<bool> _willPop() async {
    await _navigationKey.currentState!.maybePop();
    return Future.value(false);
  }

  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Navigator(
        key: _navigationKey,
        initialRoute: Routes.splash,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;

          widget.navigationStore.currentRoute = settings.name ?? '';
          // Manage your route names here
          switch (settings.name) {
            case Routes.splash:
              builder = (BuildContext context) => SplashScreen();
              break;
            case Routes.login:
              builder = (BuildContext context) => LoginScreen();
              break;
            case Routes.start:
              builder = (BuildContext context) => StartScreen();
              break;
            case Routes.home:
              builder = (BuildContext context) => _homeScreen;
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }

          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },
      ),
    );
  }

  Widget get _homeScreen => HomeScreen(
        controller: HomeScreenController(
          navigationStore: widget.navigationStore,
        ),
      );
}
