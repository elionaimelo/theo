import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/lang_icon.dart';
import 'package:theo/components/text_icon_button.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen_controller.dart';
import 'package:theo/states/locale_store.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/assets_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopSheetMenuProps {
  TopSheetMenuProps({required this.navigationStore, required this.localeStore});

  final NavigationStore navigationStore;

  final LocaleStore localeStore;
}

class TopSheetMenu extends StatefulWidget {
  const TopSheetMenu({Key? key, required this.props}) : super(key: key);

  @override
  _TopSheetMenuState createState() => _TopSheetMenuState();

  final TopSheetMenuProps props;

  static Future<void> showTopSheetMenu(
    BuildContext context,
    TopSheetMenuProps props,
  ) async {
    var transitionBuilder = (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ).drive(Tween<Offset>(
          begin: Offset(0, -1.0),
          end: Offset.zero,
        )),
        child: child,
      );
    };

    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 300),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) => TopSheetMenu(props: props),
      transitionBuilder: transitionBuilder,
    );
  }
}

class _TopSheetMenuState extends State<TopSheetMenu> {
  AppLocalizations get _locale => AppLocalizations.of(context)!;

  TopSheetMenuProps get props => widget.props;

  void navigateToRoute(String route) {
    Navigator.of(context).pop();

    // If the current route is some of the routes that the menu can navigate and replace
    if ([Routes.about, Routes.contact]
        .contains(props.navigationStore.currentNamedRoute)) {
      props.navigationStore.navigator.pushReplacementNamed(route);
    } else {
      props.navigationStore.navigator.pushNamed(route);
    }
  }

  void _changeAppLanguage(String languageCode) {
    props.localeStore.changeLocale(languageCode);

    Navigator.of(context).pop();
  }

  void _tutorialTap() {
    Navigator.of(context).pop();

    props.navigationStore.navigator.pushNamed(
      Routes.tutorial,
      arguments: TutorialScreenController(
        onSkipButtonTap: () {
          props.navigationStore.navigator.pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: TheoColors.primary,
        child: SafeArea(
          child: Column(
            children: [
              _topMenu,
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: _menu,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _appButton => Container(
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset(
            AssetsPath.appSymbolPng,
            width: 40,
            height: 40,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      );

  Widget get _topMenu => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _appButton,
            TextIconButton(
              foregroundColor: TheoColors.secondary,
              text: _locale.close,
              direction: TextDirection.rtl,
              onTap: () => Navigator.of(context).pop(),
              icon: Icon(
                FeatherIcons.x,
                size: 30,
                color: TheoColors.secondary,
              ),
            ),
          ],
        ),
      );

  Widget get _menu => Container(
        margin: EdgeInsets.only(top: 60),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextIconButton(
              foregroundColor: TheoColors.secondary,
              text: _locale.aboutApp,
              onTap: () => navigateToRoute(Routes.about),
              textStyle: _buttonTextStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 35),
            ),
            TextIconButton(
              foregroundColor: TheoColors.secondary,
              text: _locale.tutorial,
              onTap: _tutorialTap,
              textStyle: _buttonTextStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 35),
            ),
            TextIconButton(
              foregroundColor: TheoColors.secondary,
              text: _locale.contact,
              onTap: () => navigateToRoute(Routes.contact),
              textStyle: _buttonTextStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 35),
            ),
            TextIconButton(
              foregroundColor: TheoColors.secondary,
              text: _locale.language,
              onTap: () {},
              textStyle: _buttonTextStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 17),
            ),
            _ptButton,
            Container(
              margin: EdgeInsets.only(top: 14),
            ),
            _enButton,
            Container(
              margin: EdgeInsets.only(top: 14),
            ),
            _esButton,
          ],
        ),
      );

  Widget get _ptButton => TextIconButton(
        foregroundColor: TheoColors.secondary,
        text: _locale.pt,
        onTap: () => _changeAppLanguage('pt'),
        direction: TextDirection.rtl,
        icon: LangIcon(languageCode: 'pt'),
        textStyle: _langButtonTextStyle,
      );

  Widget get _enButton => TextIconButton(
        foregroundColor: TheoColors.secondary,
        text: _locale.en,
        onTap: () => _changeAppLanguage('en'),
        direction: TextDirection.rtl,
        icon: LangIcon(languageCode: 'en'),
        textStyle: _langButtonTextStyle,
      );

  Widget get _esButton => TextIconButton(
        foregroundColor: TheoColors.secondary,
        text: _locale.es,
        onTap: () => _changeAppLanguage('es'),
        direction: TextDirection.rtl,
        icon: LangIcon(languageCode: 'es'),
        textStyle: _langButtonTextStyle,
      );

  TextStyle get _buttonTextStyle =>
      Theme.of(context).textTheme.bodyText1!.copyWith(
            color: TheoColors.secondary,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          );

  TextStyle get _langButtonTextStyle =>
      Theme.of(context).textTheme.bodyText1!.copyWith(
            color: TheoColors.secondary,
            fontSize: 16,
          );
}
