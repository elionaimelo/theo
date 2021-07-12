import 'package:mobx/mobx.dart';
import 'package:supabase/supabase.dart' as sup;
import 'package:theo/models/user.dart';
import 'package:theo/services/api_client.dart';
import 'package:theo/services/auth_service.dart';
import 'package:theo/types/enums.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  _AuthStoreBase(this.client);

  final APIClient client;

  AuthService get _authService => client.authService;

  @observable
  ResultStatus resultStatus = ResultStatus.NONE;

  @observable
  User? user;

  @observable
  sup.Session? session;

  @computed
  bool get authenticated => session != null;

  @observable
  bool isReady = false;

  @action
  Future<void> signUp({required User newUser, required String password}) async {
    resultStatus = ResultStatus.LOADING;

    try {
      var response =
          await _authService.signUp(user: newUser, password: password);

      if (response == null) {
        throw Exception('Response Null');
      }

      await signIn(email: newUser.email!, password: password);

      resultStatus = ResultStatus.DONE;
    } catch (err) {
      print('AuthStore.signUp - $err');
      resultStatus = ResultStatus.ERROR;
    }
  }

  @action
  Future<void> signIn({required String email, required String password}) async {
    resultStatus = ResultStatus.LOADING;

    try {
      var response =
          await _authService.signIn(email: email, password: password);

      if (response == null) {
        throw Exception('Response Null');
      }

      session = response[0];
      user = response[1];

      resultStatus = ResultStatus.DONE;
    } catch (err) {
      print('AuthStore.signUp - $err');
      resultStatus = ResultStatus.ERROR;
    }
  }
}
