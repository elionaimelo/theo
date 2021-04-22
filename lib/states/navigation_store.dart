import 'package:mobx/mobx.dart';
part 'navigation_store.g.dart';

class NavigationStore = _NavigationStoreBase with _$NavigationStore;

enum TabPagesIndexes { HOME, LEARNING, DISCOVER, TELL }

abstract class _NavigationStoreBase with Store {
  @observable
  bool withBottomNavigationBar = false;

  @observable
  String currentRoute = '';

  @observable
  TabPagesIndexes currentTabPageIndex = TabPagesIndexes.HOME;

  @action
  void setCurrentPageIndex(TabPagesIndexes index) {
    currentTabPageIndex = index;
  }

  @action
  void setWithBottomNavigationBar(bool value) {
    withBottomNavigationBar = value;
  }
}
