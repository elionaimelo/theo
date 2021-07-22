import 'package:mobx/mobx.dart';
import 'package:theo/models/language.dart';
import 'package:theo/services/api_client.dart';
import 'package:theo/services/language_service.dart';
import 'package:theo/types/enums.dart';
part 'language_store.g.dart';

class LanguageStore = _LanguageStoreBase with _$LanguageStore;

abstract class _LanguageStoreBase with Store {
  _LanguageStoreBase(this.client);

  final APIClient client;

  LanguageService get _languageService => client.languageService;

  @observable
  List<Language> languages = [];

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @action
  Future<void> fetchLanguages() async {
    eResultStatus = EResultStatus.LOADING;

    try {
      var response = await _languageService.fetchLanguages();

      if (response == null) {
        throw Exception('Response Null');
      }

      var listResult = [...response.data];

      languages = listResult.map((e) => Language.fromJson(e)!).toList();

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      print('LanguageStore.fetchLanguages - $err');
      eResultStatus = EResultStatus.REQUEST_ERROR;
      rethrow;
    }
  }
}
