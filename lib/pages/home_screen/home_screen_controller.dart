import 'package:mobx/mobx.dart';
import 'package:theo/states/navigation.dart';
part 'home_screen_controller.g.dart';

class HomeScreenController = _HomeScreenControllerBase
    with _$HomeScreenController;

abstract class _HomeScreenControllerBase with Store {
  _HomeScreenControllerBase({required this.navigationStore});

  final NavigationStore navigationStore;

  @computed
  TabPagesIndexes get currentPageIndex => navigationStore.currentTabPageIndex;

  @action
  void setCurrentPageIndex(TabPagesIndexes index) {
    navigationStore.setCurrentPageIndex(index);
  }

  @action
  void showBottomBar() {
    navigationStore.setWithBottomNavigationBar(true);
  }
}
