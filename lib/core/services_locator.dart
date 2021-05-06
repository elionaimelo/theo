import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:theo/states/navigation_store.dart';

class ServicesLocator {
  void setup() {
    final navigatorKey = GlobalKey<NavigatorState>();

    GetIt.I.registerSingleton<NavigationStore>(
      NavigationStore(
        navigationHistory: NavigationHistoryObserver(),
        navigationKey: navigatorKey,
      ),
    );
  }
}
