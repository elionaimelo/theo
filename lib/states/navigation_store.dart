import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:theo/models/theo_app_bar_settings.dart';
part 'navigation_store.g.dart';

class NavigationStore = _NavigationStoreBase with _$NavigationStore;

enum TabPagesIndexes { HOME, LEARNING, DISCOVER, TELL }

abstract class _NavigationStoreBase with Store {
  @observable
  bool withBottomNavigationBar = false;

  @observable
  TheoAppBarSettings appBarSettings = TheoAppBarSettings();

  @observable
  bool withAppBar = false;

  @observable
  String currentNamedRoute = '';

  @observable
  GlobalKey<NavigatorState>? navigationKey;

  @observable
  TabPagesIndexes _currentTabPageIndex = TabPagesIndexes.HOME;

  @computed
  TabPagesIndexes get currentTabPageIndex => _currentTabPageIndex;

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
}
