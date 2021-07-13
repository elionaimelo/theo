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
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'components/theo_app_bar.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp() {
    _initialization = _initServices().then((value) {
      _navigationStore = GetIt.I.get();
    });
  }

  late Future<void> _initialization;
  late NavigationStore _navigationStore;

  Future<void> _initServices() async {
    await dotenv.load();

    ServicesLocator().setup();

    return;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else {
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
