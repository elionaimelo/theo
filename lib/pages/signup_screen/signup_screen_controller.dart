import 'package:mobx/mobx.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/models/language.dart';
import 'package:theo/models/profile.dart';
import 'package:theo/models/role.dart';
import 'package:theo/models/user.dart';
import 'package:theo/states/auth_store.dart';
import 'package:theo/states/language_store.dart';
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
  });

  final LanguageStore languageStore;
  final RoleStore roleStore;
  final AuthStore authStore;

  @computed
  List<Role> get roles => roleStore.roles;

  @computed
  List<Language> get languages => languageStore.languages;

  @observable
  ResultStatus resultStatus = ResultStatus.LOADING;

  @observable
  Role? selectedRole;

  @observable
  int? age = 21;

  @observable
  String? name = "";

  @observable
  String? email = "";

  @observable
  String? country = '';

  @observable
  String? password = "";

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
  Future<void> fetchData() async {
    try {
      resultStatus = ResultStatus.LOADING;

      await languageStore.fetchLanguages();

      await roleStore.fetchRoles();

      resultStatus = ResultStatus.DONE;
    } catch (err) {
      errorMessage = err.toString();
      resultStatus = ResultStatus.REQUEST_ERROR;
    }
  }

  @action
  Future<bool> signUpUser() async {
    try {
      if (password != passwordCheck) {
        ErrorAlertDialog.showAlertDialog(content: 'As senhas não conferem!');
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
      resultStatus = ResultStatus.REQUEST_ERROR;
      return false;
    }
  }
}