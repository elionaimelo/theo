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
  String currentRoute = '';

  @observable
  TabPagesIndexes currentTabPageIndex = TabPagesIndexes.HOME;

  @action
  void setCurrentPageIndex(TabPagesIndexes index) {
    currentTabPageIndex = index;
  }
}
