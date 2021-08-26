import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:theo/components/theo_bottom_bar.dart';
import 'package:theo/core/navigator.dart';
import 'package:theo/core/services_locator.dart';
import 'package:theo/pages/splash_screen/splash_screen.dart';
import 'package:theo/states/locale_store.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'components/theo_app_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<void> _initialization;
  late NavigationStore _navigationStore;
  late LocaleStore _localeStore;

  @override
  void initState() {
    super.initState();

    _initialization = _initServices();
  }

  Future<void> _initServices() async {
    await dotenv.load();

    await ServicesLocator().setup();

    _navigationStore = GetIt.I.get();
    _localeStore = GetIt.I.get();

    return;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        }

        return _buildApp;
      },
    );
  }

  Widget get _buildApp => Observer(
        builder: (_) => MaterialApp(
          locale: _localeStore.locale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('es', ''),
            Locale('pt', ''),
          ],
          title: 'Theo',
          debugShowCheckedModeBanner: false,
          theme: _theme,
          home: _home,
        ),
      );

  Widget get _home => Scaffold(
        appBar: _appBar,
        body: TheoNavigator(navigationStore: _navigationStore),
        bottomNavigationBar: TheoBottomBar(navigationStore: _navigationStore),
      );

  ThemeData get _theme => ThemeData(
        primaryColor: TheoColors.primary,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      );

  PreferredSize get _appBar => PreferredSize(
        preferredSize: Size.fromHeight(TheoMetrics.appBarHeight),
        child: TheoAppBar(
          onBackPressed: () {
            _navigationStore.navigationKey.currentState!.maybePop();
          },
          navigationStore: _navigationStore,
        ),
      );
}
