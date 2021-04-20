import 'package:get_it/get_it.dart';
import 'package:theo/states/navigation.dart';

class ServicesLocator {
  void setup() {
    GetIt.I.registerSingleton<NavigationStore>(NavigationStore());
  }
}
