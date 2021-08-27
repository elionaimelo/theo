import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/models/theo_app_bar_settings.dart';
import 'package:theo/states/auth_store.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/types/enums.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'login_screen_controller.g.dart';

class LoginScreenController = _LoginScreenControllerBase
    with _$LoginScreenController;

abstract class _LoginScreenControllerBase with Store {
  _LoginScreenControllerBase({
    required this.navigationStore,
    required this.authStore,
  });

  final NavigationStore navigationStore;
  final AuthStore authStore;

  GlobalKey<FormState> formState = GlobalKey();

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @observable
  String errorMessage = '';

  @action
  void setAppBar(TheoAppBarSettings settings) =>
      navigationStore.appBarSettings = settings;

  @action
  void onEmailTextChanged(String value) {
    email = value.split(' ').join('').toLowerCase();
  }

  @action
  void onPasswordTextChanged(String value) {
    password = value;
  }

  void onEmailButtonTap(TabController tabController) {
    if (formState.currentState!.validate()) {
      tabController.animateTo(1);
    }
  }

  @action
  Future<bool> signInUser() async {
    if (!formState.currentState!.validate()) {
      return false;
    }

    var locale = AppLocalizations.of(navigationStore.currentContext)!;

    try {
      eResultStatus = EResultStatus.LOADING;

      await authStore.signIn(email: email, password: password);

      eResultStatus = EResultStatus.DONE;

      if (authStore.authenticated) {
        await navigationStore.navigator
            .pushNamedAndRemoveUntil(Routes.home, (route) => route.isFirst);
      }

      return authStore.authenticated;
    } catch (err) {
      if (err.toString().contains('Invalid login credentials') ||
          err.toString().contains('Invalid email or password')) {
        ErrorAlertDialog.showAlertDialog(content: locale.invalidLogin);
      } else {
        ErrorAlertDialog.showAlertDialog(content: err.toString());
      }
      eResultStatus = EResultStatus.DONE;
      return false;
    }
  }
}
