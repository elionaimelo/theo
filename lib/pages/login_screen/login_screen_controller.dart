import 'package:mobx/mobx.dart';
import 'package:theo/models/theo_app_bar_settings.dart';
import 'package:theo/states/navigation_store.dart';
part 'login_screen_controller.g.dart';

class LoginScreenController = _LoginScreenControllerBase
    with _$LoginScreenController;

abstract class _LoginScreenControllerBase with Store {
  _LoginScreenControllerBase({required this.navigationStore});

  final NavigationStore navigationStore;

  String email = '';

  String password = '';

  @action
  void setAppBar(TheoAppBarSettings settings) =>
      navigationStore.appBarSettings = settings;
}
