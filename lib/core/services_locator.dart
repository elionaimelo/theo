import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:theo/services/api_client.dart';
import 'package:theo/states/auth_store.dart';
import 'package:theo/states/file_store.dart';
import 'package:theo/states/language_store.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/states/post_store.dart';
import 'package:theo/states/role_store.dart';
import 'package:theo/states/story_category_store.dart';
import 'package:theo/states/story_format_store.dart';
import 'package:theo/states/story_store.dart';

class ServicesLocator {
  void setup() {
    final navigatorKey = GlobalKey<NavigatorState>();

    var apiClient = APIClient();

    GetIt.I.registerSingleton<APIClient>(apiClient);

    GetIt.I.registerSingleton<NavigationStore>(
      NavigationStore(
        navigationHistory: NavigationHistoryObserver(),
        navigationKey: navigatorKey,
      ),
    );

    GetIt.I.registerSingleton<StoryStore>(StoryStore(apiClient));

    GetIt.I.registerSingleton<AuthStore>(AuthStore(apiClient));

    GetIt.I.registerSingleton<LanguageStore>(LanguageStore(apiClient));

    GetIt.I.registerSingleton<RoleStore>(RoleStore(apiClient));

    GetIt.I
        .registerSingleton<StoryCategoryStore>(StoryCategoryStore(apiClient));

    GetIt.I.registerSingleton<PostStore>(PostStore(apiClient));

    GetIt.I.registerSingleton<FileStore>(FileStore(apiClient));

    GetIt.I.registerSingleton<StoryFormatStore>(StoryFormatStore(apiClient));
  }
}
