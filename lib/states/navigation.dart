import 'package:mobx/mobx.dart';
part 'navigation.g.dart';

class NavigationStore = _NavigationStoreBase with _$NavigationStore;

enum TabPagesIndexes { HOME, LEARNING, DISCOVER, TELL }

abstract class _NavigationStoreBase with Store {
  @observable
  TabPagesIndexes currentTabPageIndex = TabPagesIndexes.HOME;

  @action
  void setCurrentPageIndex(TabPagesIndexes index) {
    currentTabPageIndex = index;
  }
}
