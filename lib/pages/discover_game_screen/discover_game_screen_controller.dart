import 'package:mobx/mobx.dart';
import 'package:theo/states/navigation_store.dart';
part 'discover_game_screen_controller.g.dart';

class DiscoverGameScreenController = _DiscoverGameScreenControllerBase
    with _$DiscoverGameScreenController;

abstract class _DiscoverGameScreenControllerBase with Store {
  _DiscoverGameScreenControllerBase({required this.navigationStore});

  final NavigationStore navigationStore;
}
