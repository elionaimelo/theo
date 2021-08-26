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
  EResultStatus eResultStatus = EResultStatus.NONE;

  @action
  Future<void> fetchRoles() async {
    eResultStatus = EResultStatus.LOADING;

    try {
      var response = await _roleService.fetchRoles();

      var listResult = [...response?.data];

      roles = listResult.map((e) => Role.fromJson(e)!).toList();

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      print('RoleStore.fetchRoles - $err');
      eResultStatus = EResultStatus.REQUEST_ERROR;
      rethrow;
    }
  }
}
