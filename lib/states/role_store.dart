import 'package:mobx/mobx.dart';
import 'package:theo/models/role.dart';
import 'package:theo/services/api_client.dart';
import 'package:theo/services/role_service.dart';
import 'package:theo/types/enums.dart';
part 'role_store.g.dart';

class RoleStore = _RoleStoreBase with _$RoleStore;

abstract class _RoleStoreBase with Store {
  _RoleStoreBase(this.client);

  final APIClient client;

  RoleService get _roleService => client.roleService;

  @observable
  List<Role> roles = [];

  @observable
  ResultStatus resultStatus = ResultStatus.NONE;

  @action
  Future<void> fetchRoles() async {
    resultStatus = ResultStatus.LOADING;

    try {
      var response = await _roleService.fetchRoles();

      if (response == null) {
        throw Exception('Response Null');
      }

      var listResult = [...response.data];

      roles = listResult.map((e) => Role.fromJson(e)!).toList();

      resultStatus = ResultStatus.DONE;
    } catch (err) {
      print('RoleStore.fetchRoles - $err');
      resultStatus = ResultStatus.REQUEST_ERROR;
      rethrow;
    }
  }
}
