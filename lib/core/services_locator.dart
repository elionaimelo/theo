import 'package:get_it/get_it.dart';
import 'package:theo/states/navigation_store.dart';

class ServicesLocator {
  void setup() {
    GetIt.I.registerSingleton<NavigationStore>(NavigationStore());
  }
}
