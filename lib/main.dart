import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:theo/components/theo_bottom_bar.dart';
import 'package:theo/core/navigator.dart';
import 'package:theo/core/services_locator.dart';
import 'package:theo/pages/splash_screen/splash_screen.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

import 'components/theo_app_bar.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp() {
    _initialization = _initServices();
    _navigationStore = GetIt.I.get();
  }

  late Future<void> _initialization;
  late NavigationStore _navigationStore;

  Future<void> _initServices() async {
    ServicesLocator().setup();
    await Future.delayed(Duration(seconds: 3), () {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: _initialization,
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else {
          // Loading is done, return the app:
          return _buildApp(context);
        }
      },
    );
  }

  Widget _buildApp(BuildContext context) {
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
        appBar: _appBar,
        body: TheoNavigator(navigationStore: _navigationStore),
        bottomNavigationBar: TheoBottomBar(navigationStore: _navigationStore),
      ),
    );
  }

  PreferredSize get _appBar => PreferredSize(
        preferredSize: Size.fromHeight(TheoMetrics.appBarHeight),
        child: Observer(
          builder: (_) => TheoAppBar(
            onBackPressed: () {
              _navigationStore.navigationKey.currentState!.maybePop();
            },
            navigationStore: _navigationStore,
          ),
        ),
      );
}
