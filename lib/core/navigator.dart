import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/models/theo_app_bar_settings.dart';
import 'package:theo/pages/about_screen/about_screen.dart';
import 'package:theo/pages/concluded_screen/concluded_screen.dart';
import 'package:theo/pages/concluded_screen/concluded_screen_controller.dart';
import 'package:theo/pages/contact_screen/contact_screen.dart';
import 'package:theo/pages/discover_game_screen/discover_game_screen.dart';
import 'package:theo/pages/discover_game_screen/discover_game_screen_controller.dart';
import 'package:theo/pages/discover_image_screen/discover_image_screen.dart';
import 'package:theo/pages/discover_sound_screen/discover_sound_screen.dart';
import 'package:theo/pages/graph_story_screen/graph_story_screen.dart';
import 'package:theo/pages/graph_story_screen/graph_story_screen_controller.dart';
import 'package:theo/pages/home_screen/home_screen.dart';
import 'package:theo/pages/home_screen/home_screen_controller.dart';
import 'package:theo/pages/login_screen/login_screen.dart';
import 'package:theo/pages/login_screen/login_screen_controller.dart';
import 'package:theo/pages/new_tell_screen/new_tell_screen.dart';
import 'package:theo/pages/profile_screen/profile_screen.dart';
import 'package:theo/pages/quiz_story_screen/quiz_story_screen.dart';
import 'package:theo/pages/quiz_story_screen/quiz_story_screen_controller.dart';
import 'package:theo/pages/search_screen/search_screen.dart';
import 'package:theo/pages/signup_screen/signup_screen.dart';
import 'package:theo/pages/start_screen/start_screen.dart';
import 'package:theo/pages/storytelling_learn_screen/storytelling_learn_screen.dart';
import 'package:theo/pages/storytelling_learn_screen/storytelling_learn_screen_controller.dart';
import 'package:theo/pages/text_story_screen/text_story_screen.dart';
import 'package:theo/pages/text_story_screen/text_story_screen_controller.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen_controller.dart';
import 'package:theo/pages/video_story_screen/video_story_screen.dart';
import 'package:theo/pages/video_story_screen/video_story_screen_controller.dart';
import 'package:theo/states/navigation_store.dart';

class TheoNavigator extends StatefulWidget {
  TheoNavigator({required this.navigationStore});
  @override
  _TheoNavigatorState createState() => _TheoNavigatorState();

  final NavigationStore navigationStore;
}

class _TheoNavigatorState extends State<TheoNavigator> {
  final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

  @override
  void initState() {
    super.initState();

    // Event actioned when a navigation change occours
    widget.navigationStore.navigationHistory.historyChangeStream
        .listen((event) {
      handleAppBarByRoute();
    });
  }

  void handleAppBarByRoute() {
    var route = widget.navigationStore.currentNamedRoute;

    switch (route) {
      case Routes.discoverGame:
      case Routes.start:
      case Routes.videoStory:
      case Routes.textStory:
      case Routes.quizStory:
      case Routes.graphStory:
      case Routes.tutorial:
      case Routes.discoverImage:
      case Routes.discoverSound:
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          widget.navigationStore.hideAppBars();
        });
        break;
      case Routes.home:
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          widget.navigationStore.showAppBars();
          widget.navigationStore.appBarSettings =
              widget.navigationStore.appBarSettings.copyWith(
            withBackButton: widget.navigationStore.currentTabPageIndex !=
                TabPagesIndexes.HOME,
            withProfile: true,
            withMenu: true,
          );
        });
        break;
      case Routes.storytellingLearn:
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          widget.navigationStore.showAppBars();
        });
        break;
      case Routes.login:
      case Routes.signup:
        widget.navigationStore.appBarSettings =
            TheoAppBarSettings(visible: true, withBackButton: true);
        break;
      default:
        break;
    }
  }

  Future<bool> _willPop() async {
    await widget.navigationStore.navigationKey.currentState!.maybePop();
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Navigator(
        observers: [widget.navigationStore.navigationHistory],
        key: widget.navigationStore.navigationKey,
        initialRoute: Routes.start,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;

          switch (settings.name) {
            case '/':
            case Routes.start:
              builder = (BuildContext context) => StartScreen();
              break;
            case Routes.signup:
              builder = (BuildContext context) => SignupScreen();
              break;
            case Routes.login:
              builder = (BuildContext context) => _loginScreen;
              break;
            case Routes.tutorial:
              builder = (BuildContext context) => TutorialScreen(
                    controller: settings.arguments as TutorialScreenController,
                  );
              break;
            case Routes.home:
              builder = (BuildContext context) => _homeScreen;
              break;
            case Routes.about:
              builder = (BuildContext context) => AboutScreen();
              break;
            case Routes.contact:
              builder = (BuildContext context) => ContactScreen();
              break;
            case Routes.search:
              builder = (BuildContext context) => SearchScreen();
              break;
            case Routes.newTell:
              builder = (BuildContext context) =>
                  NewTellScreen(args: settings.arguments as NewTellScreenArgs);
              break;
            case Routes.profile:
              builder = (BuildContext context) => ProfileScreen();
              break;
            case Routes.discoverGame:
              builder = (BuildContext context) => _discoverScreen;
              break;
            case Routes.videoStory:
              builder = (BuildContext context) => VideoStoryScreen(
                    controller:
                        settings.arguments as VideoStoryScreenController,
                  );
              break;
            case Routes.storytellingLearn:
              builder = (BuildContext context) => _storytellingScreen;
              break;
            case Routes.textStory:
              builder = (BuildContext context) => TextStoryScreen(
                    controller: settings.arguments as TextStoryScreenController,
                  );
              break;
            case Routes.quizStory:
              builder = (BuildContext context) => QuizStoryScreen(
                    controller: settings.arguments as QuizStoryScreenController,
                  );
              break;
            case Routes.graphStory:
              builder = (BuildContext context) => GraphStoryScreen(
                    controller:
                        settings.arguments as GraphStoryScreenController,
                  );
              break;
            case Routes.concluded:
              builder = (BuildContext context) => ConcludedScreen(
                    controller: settings.arguments as ConcludedScreenController,
                  );
              break;
            case Routes.discoverImage:
              builder = (BuildContext context) => DiscoverImageScreen();
              break;
            case Routes.discoverSound:
              builder = (BuildContext context) => DiscoverSoundScreen();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }

          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },
      ),
    );
  }

  Widget get _storytellingScreen => StorytellingLearnScreen(
        controller: StorytellingLearnScreenController(
          storyStore: GetIt.I.get(),
        ),
      );

  Widget get _discoverScreen => DiscoverGameScreen(
        controller: DiscoverGameScreenController(
          navigationStore: widget.navigationStore,
        ),
      );

  Widget get _homeScreen => HomeScreen(
        controller: HomeScreenController(
          navigationStore: widget.navigationStore,
        ),
      );

  Widget get _loginScreen => LoginScreen(
        controller: LoginScreenController(
          navigationStore: widget.navigationStore,
        ),
      );
}
