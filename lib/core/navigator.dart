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
import 'package:theo/pages/discover_sound_screen/discover_sound_screen_controller.dart';
import 'package:theo/pages/graph_story_screen/graph_story_screen.dart';
import 'package:theo/pages/graph_story_screen/graph_story_screen_controller.dart';
import 'package:theo/pages/home_screen/home_screen.dart';
import 'package:theo/pages/home_screen/home_screen_controller.dart';
import 'package:theo/pages/login_screen/login_screen.dart';
import 'package:theo/pages/login_screen/login_screen_controller.dart';
import 'package:theo/pages/media_story_screen/media_story_screen.dart';
import 'package:theo/pages/media_story_screen/media_story_screen_controller.dart';
import 'package:theo/pages/new_tell_screen/new_tell_screen.dart';
import 'package:theo/pages/profile_screen/profile_screen.dart';
import 'package:theo/pages/quiz_story_screen/quiz_story_screen.dart';
import 'package:theo/pages/quiz_story_screen/quiz_story_screen_controller.dart';
import 'package:theo/pages/search_screen/search_screen.dart';
import 'package:theo/pages/signup_screen/signup_screen.dart';
import 'package:theo/pages/signup_screen/signup_screen_controller.dart';
import 'package:theo/pages/start_screen/start_screen.dart';
import 'package:theo/pages/storytelling_learn_screen/storytelling_learn_screen.dart';
import 'package:theo/pages/storytelling_learn_screen/storytelling_learn_screen_controller.dart';
import 'package:theo/pages/text_story_screen/text_story_screen.dart';
import 'package:theo/pages/text_story_screen/text_story_screen_controller.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen_controller.dart';
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
      case Routes.mediaStory:
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
          Widget page;

          switch (settings.name) {
            case '/':
            case Routes.start:
              page = StartScreen();
              break;
            case Routes.signup:
              page = _signupScreen;
              break;
            case Routes.login:
              page = _loginScreen;
              break;
            case Routes.tutorial:
              page = TutorialScreen(
                controller: settings.arguments as TutorialScreenController,
              );
              break;
            case Routes.home:
              page = _homeScreen;
              break;
            case Routes.about:
              page = AboutScreen();
              break;
            case Routes.contact:
              page = ContactScreen();
              break;
            case Routes.search:
              page = SearchScreen();
              break;
            case Routes.newTell:
              page =
                  NewTellScreen(args: settings.arguments as NewTellScreenArgs);
              break;
            case Routes.profile:
              page = ProfileScreen();
              break;
            case Routes.discoverGame:
              page = _discoverScreen;
              break;
            case Routes.mediaStory:
              page = MediaStoryScreen(
                controller: settings.arguments as MediaStoryScreenController,
              );
              break;
            case Routes.storytellingLearn:
              page = _storytellingScreen;
              break;
            case Routes.textStory:
              page = TextStoryScreen(
                controller: settings.arguments as TextStoryScreenController,
              );
              break;
            case Routes.quizStory:
              page = QuizStoryScreen(
                controller: settings.arguments as QuizStoryScreenController,
              );
              break;
            case Routes.graphStory:
              page = GraphStoryScreen(
                controller: settings.arguments as GraphStoryScreenController,
              );
              break;
            case Routes.concluded:
              page = ConcludedScreen(
                controller: settings.arguments as ConcludedScreenController,
              );
              break;
            case Routes.discoverImage:
              page = DiscoverImageScreen();
              break;
            case Routes.discoverSound:
              page = DiscoverSoundScreen(
                controller: settings.arguments as DiscoverSoundScreenController,
              );
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }

          var builder = (BuildContext context, Animation<double> anim1,
                  Animation<double> anim2) =>
              page;

          return PageRouteBuilder(
            pageBuilder: builder,
            settings: settings,
            transitionsBuilder: _transitionBuilder,
          );
        },
      ),
    );
  }

  SlideTransition _transitionBuilder(
      context, animation, secondaryAnimation, child) {
    var begin = Offset(0.0, 1.0);
    var end = Offset.zero;
    var curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
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
          authStore: GetIt.I.get(),
        ),
      );

  Widget get _signupScreen => SignupScreen(
        controller: SignupScreenController(
          languageStore: GetIt.I.get(),
          roleStore: GetIt.I.get(),
          authStore: GetIt.I.get(),
        ),
      );
}
