import 'package:flutter/material.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/pages/home_screen/home_screen.dart';
import 'package:theo/pages/home_screen/home_screen_controller.dart';
import 'package:theo/pages/login_screen/login_screen.dart';
import 'package:theo/pages/login_screen/login_screen_controller.dart';
import 'package:theo/pages/new_tell_screen/new_tell_screen.dart';
import 'package:theo/pages/splash_screen/splash_screen.dart';
import 'package:theo/pages/start_screen/start_screen.dart';
import 'package:theo/states/navigation_store.dart';

class TheoNavigator extends StatefulWidget {
  TheoNavigator({required this.navigationStore, required this.navigationKey});
  @override
  _TheoNavigatorState createState() => _TheoNavigatorState();

  final NavigationStore navigationStore;
  final GlobalKey<NavigatorState> navigationKey;
}

class _TheoNavigatorState extends State<TheoNavigator> {
  _TheoNavigatorState() {}
  @override
  void initState() {
    super.initState();

    widget.navigationStore.navigationKey = widget.navigationKey;
  }

  Future<bool> _willPop() async {
    await widget.navigationKey.currentState!.maybePop();
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Navigator(
        key: widget.navigationKey,
        initialRoute: Routes.splash,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;

          widget.navigationStore.currentNamedRoute = settings.name!;

          // Manage your route names here
          switch (settings.name) {
            case Routes.splash:
              builder = (BuildContext context) => SplashScreen();
              break;
            case Routes.login:
              builder = (BuildContext context) => _loginScreen;
              break;
            case Routes.start:
              builder = (BuildContext context) => StartScreen();
              break;
            case Routes.home:
              builder = (BuildContext context) => _homeScreen;
              break;
            case Routes.newTell:
              builder = (BuildContext context) =>
                  NewTellScreen(args: settings.arguments as NewTellScreenArgs);
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

  Widget get _loginScreen => LoginScreen(
        controller:
            LoginScreenController(navigationStore: widget.navigationStore),
      );
}
