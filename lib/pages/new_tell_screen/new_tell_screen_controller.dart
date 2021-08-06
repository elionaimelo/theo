import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/components/inputs/multi_selector_button_input.dart';
import 'package:theo/models/language.dart';
import 'package:theo/models/story.dart';
import 'package:theo/models/story_category.dart';
import 'package:theo/models/story_format.dart';
import 'package:theo/states/auth_store.dart';
import 'package:theo/states/language_store.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/states/post_store.dart';
import 'package:theo/states/story_category_store.dart';
import 'package:theo/types/enums.dart';
import 'package:theo/values/error_messages.dart';
part 'new_tell_screen_controller.g.dart';

class NewTellScreenController = _NewTellScreenControllerBase
    with _$NewTellScreenController;

abstract class _NewTellScreenControllerBase with Store {
  _NewTellScreenControllerBase({
    required this.format,
    required this.withLink,
    required this.withArchive,
    required this.navigationStore,
    required this.languageStore,
    required this.storyCategoryStore,
    required this.postStore,
    required this.authStore,
  });

  final bool withLink;
  final bool withArchive;
  final StoryFormat format;

  final NavigationStore navigationStore;
  final LanguageStore languageStore;
  final StoryCategoryStore storyCategoryStore;
  final PostStore postStore;
  final AuthStore authStore;

  @computed
  List<Language> get languages => languageStore.languages;

  @computed
  List<StoryCategory> get storyCategories => storyCategoryStore.storyCategories;

  @observable
  Language? selectedLanguage;

  @observable
  StoryCategory? selectedCategory;

  @observable
  String? title;

  @observable
  String? description;

  @observable
  String? author;

  @observable
  String? url;

  @observable
  String? tag1;

  @observable
  String? tag2;

  @observable
  String? tag3;

  @observable
  bool? adultContent;

  @observable
  List<String> imagesPaths = [];

  @observable
  String? videoFilePath;

  @observable
  String? archivePath;

  @observable
  EResultStatus eResultStatus = EResultStatus.NONE;

  @observable
  String? errorMessage = '';

  @action
  void onTitleTextChanged(String value) {
    title = value;
  }

  @action
  void onDescTextChanged(String value) {
    description = value;
  }

  @action
  void onAuthorTextChanged(String value) {
    author = value;
  }

  @action
  void onLinkTextChanged(String value) {
    url = value;
  }

  @action
  void onLangSelectionChanged(String? displayName) {
    selectedLanguage =
        languages.firstWhere((element) => element.displayName == displayName);
  }

  @action
  void onContentAgeChanged(List<SelectorItem> items) {
    try {
      adultContent = items.first.value;
    } catch (err) {
      print('NewTellScreenController.onContentAgeChanged - $err');
    }
  }

  @action
  void onSelectedCategoriesChanged(List<SelectorItem> items) {
    try {
      selectedCategory = items.first.value;
    } catch (err) {
      print('NewTellScreenController.onSelectedCategoriesChanged - $err');
    }
  }

  @action
  void onKeyword1TextChanged(String value) {
    tag1 = value;
  }

  @action
  void onKeyword2TextChanged(String value) {
    tag2 = value;
  }

  @action
  void onKeyword3TextChanged(String value) {
    tag3 = value;
  }

  @action
  void onImagesPathsSelected(List<String> paths) {
    imagesPaths = paths;
  }

  @action
  void onVideoFilePathSelected(String value) {
    videoFilePath = value;
  }

  @action
  void onArchivePathSelected(String value) {
    archivePath = value;
  }

  @action
  Future<void> fetchData() async {
    try {
      eResultStatus = EResultStatus.LOADING;

      await languageStore.fetchLanguages();

      await storyCategoryStore.fetchStoryCategories();

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      eResultStatus = EResultStatus.REQUEST_ERROR;
      errorMessage = err.toString();
    }
  }

  @action
  Future<void> onPublishButtonTap(FormState formState) async {
    try {
      eResultStatus = EResultStatus.LOADING;
      var isValid = formState.validate();

      if (!isValid) {
        throw ErrorMessages.VALIDATION_ERROR;
      }

      var newStory = Story(
        adultContent: adultContent,
        author: author,
        description: description,
        tags: [tag1 ?? '', tag2 ?? '', tag3 ?? ''],
        title: title,
        url: url,

        //-----//
        languageId: selectedLanguage!.id,
        language: selectedLanguage,
        formatId: format.id,
        format: format,
        category: selectedCategory,
        categoryId: selectedCategory!.id,
      );

      var filesPath = [
        ...imagesPaths,
        if (archivePath != null) archivePath!,
        if (videoFilePath != null) videoFilePath!
      ];

      await postStore.createPost(
        story: newStory,
        filesPath: filesPath,
        user: authStore.user!,
      );

      ErrorAlertDialog.showAlertDialog(
          title: 'Sucesso!', content: 'Estória publicada com sucesso!');

      eResultStatus = EResultStatus.DONE;
    } catch (err) {
      ErrorAlertDialog.showAlertDialog(content: err.toString());
      eResultStatus = EResultStatus.DONE;
    }
  }
}
