import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:theo/models/story_category.dart';
import 'package:theo/models/theo_app_bar_settings.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/states/story_category_store.dart';
import 'package:theo/types/enums.dart';
part 'home_screen_controller.g.dart';

class HomeScreenController = _HomeScreenControllerBase
    with _$HomeScreenController;

abstract class _HomeScreenControllerBase with Store {
  _HomeScreenControllerBase({
    required this.navigationStore,
    required this.storyCategoryStore,
  });

  final NavigationStore navigationStore;
  final StoryCategoryStore storyCategoryStore;

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @observable
  String? errorMessage = '';

  @computed
  List<StoryCategory> get storyCategories => storyCategoryStore.storyCategories;

  @action
  Future<void> fetchData() async {
    try {
      eResultStatus = EResultStatus.LOADING;

      await storyCategoryStore.fetchStoryCategories();

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      errorMessage = err.toString();
      eResultStatus = EResultStatus.REQUEST_ERROR;
    }
  }

  @computed
  TabPagesIndexes get currentPageIndex => navigationStore.currentTabPageIndex;

  @action
  void setCurrentPageIndex(TabPagesIndexes index) {
    navigationStore.setCurrentPageIndex(index);
  }

  @action
  void showBottomBar() {
    navigationStore.withBottomNavigationBar = true;
  }

  @action
  void setAppBar(TheoAppBarSettings settings) {
    navigationStore.appBarSettings = settings;
  }

  @action
  void onTabControllerEvent(TabController tab) {
    if (tab.index != currentPageIndex.index) {
      setCurrentPageIndex(TabPagesIndexes.values[tab.index]);
    }
  }
}
