import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:theo/models/theo_app_bar_settings.dart';
import 'package:theo/states/navigation_store.dart';
part 'home_screen_controller.g.dart';

class HomeScreenController = _HomeScreenControllerBase
    with _$HomeScreenController;

abstract class _HomeScreenControllerBase with Store {
  _HomeScreenControllerBase({required this.navigationStore}) {}

  final NavigationStore navigationStore;

  @computed
  TabPagesIndexes get currentPageIndex => navigationStore.currentTabPageIndex;

  @action
  void setCurrentPageIndex(TabPagesIndexes index) {
    navigationStore.setCurrentPageIndex(index);

    navigationStore.appBarSettings = TheoAppBarSettings(
      visible: true,
      withBackButton: index != TabPagesIndexes.HOME,
      withMenu: true,
      withProfile: true,
    );
  }

  @action
  void showBottomBar() {
    navigationStore.withBottomNavigationBar = true;
  }

  @action
  void onTabControllerEvent(TabController tab) {
    if (tab.index != currentPageIndex.index) {
      setCurrentPageIndex(TabPagesIndexes.values[tab.index]);
    }
  }
}
