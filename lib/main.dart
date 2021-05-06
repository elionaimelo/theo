import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:theo/components/theo_bottom_bar.dart';
import 'package:theo/core/navigator.dart';
import 'package:theo/core/services_locator.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

import 'components/theo_app_bar.dart';

void main() {
  ServicesLocator().setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NavigationStore _navigationStore = GetIt.I.get();

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
            settings: _navigationStore.appBarSettings,
            onBackPressed: () async {
              var result =
                  await _navigationStore.navigationKey.currentState!.maybePop();
              print(result);
            },
          ),
        ),
      );
}
