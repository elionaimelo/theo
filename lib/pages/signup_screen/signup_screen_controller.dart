import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/models/language.dart';
import 'package:theo/models/profile.dart';
import 'package:theo/models/role.dart';
import 'package:theo/models/user.dart';
import 'package:theo/pages/concluded_screen/concluded_screen_controller.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen_controller.dart';
import 'package:theo/states/auth_store.dart';
import 'package:theo/states/language_store.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/states/role_store.dart';
import 'package:theo/types/enums.dart';
part 'signup_screen_controller.g.dart';

class SignupScreenController = _SignupScreenControllerBase
    with _$SignupScreenController;

abstract class _SignupScreenControllerBase with Store {
  _SignupScreenControllerBase({
    required this.languageStore,
    required this.roleStore,
    required this.authStore,
    required this.navigationStore,
  });

  final LanguageStore languageStore;
  final RoleStore roleStore;
  final AuthStore authStore;
  final NavigationStore navigationStore;

  GlobalKey<FormState> formState = GlobalKey();

  @computed
  List<Role> get roles => roleStore.roles;

  @computed
  List<Language> get languages => languageStore.languages;

  @observable
  double currentBarValue = 0;

  @observable
  EResultStatus eResultStatus = EResultStatus.LOADING;

  @observable
  Role? selectedRole;

  @observable
  int? age = 21;

  @observable
  String? name = '';

  @observable
  String? email = '';

  @observable
  String? country = '';

  @observable
  String? password = '';

  @observable
  String? passwordCheck = '';

  @observable
  String? errorMessage = '';

  @action
  void onEmailTextChanged(String value) {
    email = value;
  }

  @action
  void onNameTextChanged(String value) {
    name = value;
  }

  @action
  void onPasswordTextChanged(String value) {
    password = value;
  }

  @action
  void onPasswordCheckTextChanged(String value) {
    passwordCheck = value;
  }

  @action
  void onCountryTextChanged(String value) {
    country = value;
  }

  @action
  void onAgeSelected(int index) {
    switch (index) {
      case 0:
        age = 19;
        break;
      case 1:
        age = 29;
        break;
      case 2:
        age = 39;
        break;
      case 3:
        age = 49;
        break;
      case 4:
        age = 50;
        break;
      default:
    }
  }

  @action
  void onRoleSelected(int index) {
    selectedRole = roles[index];
  }

  @action
  Future<bool> onBackPressed(TabController tabController) async {
    if (tabController.index > 0) {
      tabController.animateTo(tabController.index - 1);
      currentBarValue -= 1;
      return false;
    }

    navigationStore.navigator.pop();

    return true;
  }

  @action
  Future<void> onNextButtonTap(
      TabController tabController, BuildContext context) async {
    if (!formState.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    var index = tabController.index;
    if (index + 1 >= tabController.length /*- 1*/) {
      var succeeded = await signUpUser();

      if (succeeded) {
        await navigationStore.navigator.pushNamed(
          Routes.concluded,
          arguments: ConcludedScreenController(
            message: 'O seu perfil já está pronto.',
            title: 'Concluído!',
            onNextButtonTap: _navigateToTutorialOrHome,
          ),
        );
      }

      return;
    }

    tabController.animateTo(index + 1);

    currentBarValue =
        (index.toDouble() + 1) / (tabController.length.toDouble() - 1);
  }

  @action
  Future<void> _navigateToTutorialOrHome() async {
    navigationStore.navigator.popUntil((route) => route.isFirst);

    if (await TutorialScreen.isFirstShow()) {
      await navigationStore.navigator.pushNamed(
        Routes.tutorial,
        arguments: TutorialScreenController(),
      );
    } else {
      await navigationStore.navigator.pushNamed(Routes.home);
    }
  }

  @action
  Future<void> fetchData() async {
    try {
      eResultStatus = EResultStatus.LOADING;

      await languageStore.fetchLanguages();

      await roleStore.fetchRoles();

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      errorMessage = err.toString();
      eResultStatus = EResultStatus.REQUEST_ERROR;
    }
  }

  @action
  Future<bool> signUpUser() async {
    try {
      eResultStatus = EResultStatus.LOADING;

      if (password != passwordCheck) {
        ErrorAlertDialog.showAlertDialog(content: 'As senhas não conferem!');
        eResultStatus = EResultStatus.DONE;
        return false;
      }

      await authStore.signUp(
        newUser: User(
          canceled: false,
          email: email,
          profile: Profile(
            age: age,
            name: name,
            country: country,
            language: languages.first,
            languageId: languages.first.id,
          ),
          role: selectedRole,
          roleId: selectedRole!.id,
          termAccepted: true,
        ),
        password: password!,
      );

      return authStore.authenticated;
    } catch (err) {
      errorMessage = err.toString();

      ErrorAlertDialog.showAlertDialog(content: errorMessage!);

      eResultStatus = EResultStatus.DONE;
      return false;
    }
  }
}
