import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/models/theo_app_bar_settings.dart';
part 'navigation_store.g.dart';

class NavigationStore = _NavigationStoreBase with _$NavigationStore;

enum TabPagesIndexes { HOME, LEARNING, DISCOVER, TELL }

abstract class _NavigationStoreBase with Store {
  _NavigationStoreBase({
    required this.navigationHistory,
    required this.navigationKey,
  });

  final NavigationHistoryObserver navigationHistory;

  final GlobalKey<NavigatorState> navigationKey;

  @observable
  bool withBottomNavigationBar = false;

  @observable
  TheoAppBarSettings appBarSettings = TheoAppBarSettings();

  @observable
  TabPagesIndexes _currentTabPageIndex = TabPagesIndexes.HOME;

  String? get currentNamedRoute => navigationHistory.history.last.settings.name;

  @computed
  TabPagesIndexes get currentTabPageIndex => _currentTabPageIndex;

  @computed
  NavigatorState get navigator => Navigator.of(navigationKey.currentContext!);

  @action
  void setCurrentPageIndex(TabPagesIndexes index) {
    _currentTabPageIndex = index;

    appBarSettings = TheoAppBarSettings(
      visible: true,
      withBackButton: index != TabPagesIndexes.HOME,
      withMenu: true,
      withProfile: true,
    );
  }

  @action
  void popUntil(String routeName) {
    navigator.popUntil((route) {
      return currentNamedRoute == Routes.home;
    });
  }

  @action
  void showAppBars() {
    if (!withBottomNavigationBar || !appBarSettings.visible) {
      withBottomNavigationBar = true;
      appBarSettings = appBarSettings.copyWith(visible: true);
    }
  }

  @action
  void hideAppBars() {
    if (withBottomNavigationBar || appBarSettings.visible) {
      withBottomNavigationBar = false;
      appBarSettings = appBarSettings.copyWith(visible: false);
    }
  }
}
