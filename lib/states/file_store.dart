import 'package:mobx/mobx.dart';
import 'package:theo/models/file.dart';
import 'package:theo/services/api_client.dart';
import 'package:theo/services/file_service.dart';
import 'package:theo/types/enums.dart';
part 'file_store.g.dart';

class FileStore = _FileStoreBase with _$FileStore;

abstract class _FileStoreBase with Store {
  _FileStoreBase(this.client);

  final APIClient client;

  FileService get _fileService => client.fileService;

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @action
  Future<String> getFileSignedUrl(File file) async {
    eResultStatus = EResultStatus.LOADING;

    try {
      var response = await _fileService.getFileSignedUrl(file);

      if (response == null) {
        throw Exception('Response Null');
      }

      eResultStatus = EResultStatus.DONE;

      return response;
    } catch (err) {
      print('FileStore.getFileSignedUrl - $err');
      eResultStatus = EResultStatus.REQUEST_ERROR;
      rethrow;
    }
  }
}
