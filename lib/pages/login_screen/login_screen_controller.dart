import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/models/theo_app_bar_settings.dart';
import 'package:theo/states/auth_store.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/types/enums.dart';
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

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  ResultStatus resultStatus = ResultStatus.NONE;

  @observable
  String errorMessage = '';

  @action
  void setAppBar(TheoAppBarSettings settings) =>
      navigationStore.appBarSettings = settings;

  @action
  void onEmailTextChanged(String value) {
    email = value;
  }

  @action
  void onPasswordTextChanged(String value) {
    password = value;
  }

  @action
  Future<bool> signInUser() async {
    try {
      resultStatus = ResultStatus.LOADING;

      await authStore.signIn(email: email, password: password);

      resultStatus = ResultStatus.DONE;

      return authStore.authenticated;
    } catch (err) {
      ErrorAlertDialog.showAlertDialog(content: err.toString());
      resultStatus = ResultStatus.DONE;
      return false;
    }
  }
}
