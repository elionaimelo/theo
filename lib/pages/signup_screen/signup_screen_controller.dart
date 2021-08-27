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
import 'package:theo/states/locale_store.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/states/role_store.dart';
import 'package:theo/types/enums.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:theo/values/error_messages.dart';

part 'signup_screen_controller.g.dart';

class SignupScreenController = _SignupScreenControllerBase
    with _$SignupScreenController;

abstract class _SignupScreenControllerBase with Store {
  _SignupScreenControllerBase({
    required this.languageStore,
    required this.roleStore,
    required this.authStore,
    required this.navigationStore,
    required this.localeStore,
  });

  final LanguageStore languageStore;
  final RoleStore roleStore;
  final AuthStore authStore;
  final NavigationStore navigationStore;
  final LocaleStore localeStore;

  TabController? tabController;

  GlobalKey<FormState> formState = GlobalKey();

  @computed
  List<Role> get roles => roleStore.roles;

  @computed
  List<Language> get languages => languageStore.languages;

  @observable
  double currentBarValue = 0;

  @observable
  int tabIndex = 0;

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
  void setTabController(TabController controller) {
    tabController = controller;

    if (tabController != null) {
      tabController!.addListener(() {
        setTabIndex(tabController!.index);
      });
    }
  }

  void dispose() {
    tabController?.dispose();
  }

  @action
  void setTabIndex(int index) {
    tabIndex = index;
  }

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
  void onLanguageSelected(BuildContext context, int index) {
    if (languages[index].name != null) {
      localeStore.changeLocale(languages[index].name!);

      onNextButtonTap(context);
    }
  }

  @action
  Future<bool> onBackPressed() async {
    var tabIndex = tabController?.index ?? 0;

    if (tabIndex > 0) {
      tabController!.animateTo(tabIndex - 1);
      currentBarValue -= 1;
      return false;
    }

    navigationStore.navigator.pop();

    return true;
  }

  @action
  Future<void> onNextButtonTap(BuildContext context) async {
    if (!formState.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    var index = tabController?.index ?? 0;
    var length = tabController?.length ?? 0;

    if (index + 1 >= length) {
      var succeeded = await signUpUser();

      if (succeeded) {
        await navigationStore.navigator.pushNamed(
          Routes.concluded,
          arguments: ConcludedScreenController(
            message: AppLocalizations.of(context)!.concludedMessage,
            title: AppLocalizations.of(context)!.concluded + '!',
            onNextButtonTap: _navigateToTutorialOrHome,
          ),
        );
      }

      return;
    }

    tabController?.animateTo(index + 1);

    currentBarValue = (index.toDouble() + 1) / (length.toDouble() - 1);
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
        ErrorAlertDialog.showAlertDialog(
          content: ErrorMessages.of(navigationStore.currentContext)
              .INVALID_MATCH_PASSWORD,
        );
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
